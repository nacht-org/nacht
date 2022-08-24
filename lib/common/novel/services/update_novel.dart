import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' show Value, DoUpdate;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../mappers/source_chapter_into_companion.dart';
import '../mappers/source_metadata_into_companion.dart';
import '../mappers/source_novel_into_companion.dart';
import '../mappers/source_volume_into_companion.dart';

part 'update_novel.freezed.dart';

final updateNovelProvider = Provider<UpdateNovel>(
  (ref) => UpdateNovel(
    database: ref.watch(databaseProvider),
  ),
  name: 'UpdateNovelRoutineProvider',
);

class UpdateNovel with LoggerMixin {
  UpdateNovel({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, UpdateResult>> execute(sources.Novel novel) async {
    UpdateResult result =
        UpdateResult(isInitial: true, novelId: -1, insertedIds: []);

    await _database.transaction(() async {
      result = await _updateNovel(novel);

      final volumes = await _updateVolumes(novel.volumes, result.novelId);
      final inserts = await _updateChapters(volumes, result.novelId);

      // Insert chapters.
      log.fine('inserting chapters');
      final insertedIds = <int>[];
      for (final companion in inserts) {
        final id = await _database.into(_database.chapters).insert(companion);
        insertedIds.add(id);
      }

      result = result.copyWith(insertedIds: insertedIds);

      // Update metadata.
      await _updateMetaData(result.novelId, novel.metadata);
    });

    // FIXME: handle where transaction failed

    log.fine('ending novel update');

    return Right(result);
  }

  Future<UpdateResult> _updateNovel(sources.Novel novel) async {
    final companion = sourceNovelIntoCompanion(novel);

    // Upsert the novel entity itself
    final currentNovel = await (_database.select(_database.novels)
          ..where((tbl) => tbl.url.equals(companion.url.value)))
        .getSingleOrNull();

    final isInitial = currentNovel == null;
    final int id;

    if (isInitial) {
      id = await _database.into(_database.novels).insert(companion);
    } else {
      await (_database.update(_database.novels)
            ..where((tbl) => tbl.id.equals(currentNovel.id)))
          .write(companion);

      id = currentNovel.id;
    }

    return UpdateResult(isInitial: isInitial, novelId: id, insertedIds: []);
  }

  Future<Map<Volume, List<sources.Chapter>>> _updateVolumes(
    List<sources.Volume> volumes,
    int novelId,
  ) async {
    log.fine('syncing volumes');
    final volumeModels = <Volume, List<sources.Chapter>>{};
    for (final volume in volumes) {
      final volumeCompanion =
          sourceVolumeIntoCompanion(volume).copyWith(novelId: Value(novelId));

      final model = await _database.into(_database.volumes).insertReturning(
          volumeCompanion,
          onConflict: DoUpdate(
            (old) => volumeCompanion,
            target: [_database.volumes.novelId, _database.volumes.volumeIndex],
          ));

      volumeModels[model] = volume.chapters;
    }

    return volumeModels;
  }

  Future<List<ChaptersCompanion>> _updateChapters(
    Map<Volume, List<sources.Chapter>> volumes,
    int novelId,
  ) async {
    final insertCompanions = <ChaptersCompanion>[];

    final newChapters = <_ChapterWrapper>[];
    for (final entry in volumes.entries) {
      newChapters.addAll(
        entry.value.map((chapter) => _ChapterWrapper(chapter, entry.key.id)),
      );
    }

    final currentChapters = await (_database.select(_database.chapters)
          ..where((tbl) => tbl.novelId.equals(novelId)))
        .get();

    log.fine('updating and removing chapters');
    await _database.batch((batch) async {
      final diff = calculateDiff<Chapter, _ChapterWrapper>(
        prev: IdentityList<Chapter, String>(
          items: currentChapters,
          identity: (item) => item.url,
        ),
        next: IdentityList<_ChapterWrapper, String>(
          items: newChapters,
          identity: (item) => item.chapter.url,
        ),
        equality: (prev, next) {
          return prev.title == next.chapter.title &&
              prev.updated == next.chapter.updated &&
              prev.chapterIndex == next.chapter.index &&
              prev.volumeId == next.volumeId;
        },
      );

      for (final change in diff) {
        change.when(
          insert: (next) async {
            final chapterCompanion =
                sourceChapterIntoCompanion(next.chapter).copyWith(
              volumeId: Value(next.volumeId),
              novelId: Value(novelId),
            );

            insertCompanions.add(chapterCompanion);
            log.finer(
                'insert chapter ${next.chapter.index} ${next.chapter.title}');
          },
          remove: (prev) {
            batch.delete(_database.chapters, prev);
            log.finer('remove chapter ${prev.chapterIndex} ${prev.title}');
          },
          replace: (prev, next) {
            final chapterCompanion =
                sourceChapterIntoCompanion(next.chapter).copyWith(
              id: Value(prev.id),
              volumeId: Value(next.volumeId),
              novelId: Value(novelId),
            );

            batch.replace(_database.chapters, chapterCompanion);
            log.finer(
                'replace chapter ${next.chapter.index} ${next.chapter.title}');
          },
          keep: (prev, next) {
            log.finer(
                'keep chapter ${next.chapter.index} ${next.chapter.title}');
          },
        );
      }
    });

    return insertCompanions;
  }

  _updateMetaData(int novelId, List<sources.MetaData> metaData) async {
    log.info('syncing metadata.');

    final currentMetaData = await (_database.select(_database.metaEntries)
          ..where((tbl) => tbl.novelId.equals(novelId)))
        .get();

    final diff = calculateDiff<MetaEntry, sources.MetaData>(
      prev: IdentityList<MetaEntry, Tuple2>(
        items: currentMetaData,
        identity: (item) => Tuple2(item.name, item.value),
      ),
      next: IdentityList<sources.MetaData, Tuple2>(
        items: metaData,
        identity: (item) => Tuple2(item.name, item.value),
      ),
      equality: (prev, next) =>
          (prev.others == null
              ? null
              : Map<String, Object>.from(json.decode(prev.others!))) ==
          next.others,
    );

    await _database.batch((batch) {
      for (final change in diff) {
        change.map(
          insert: (state) {
            final companion = sourceMetaDataIntoCompanion(state.data)
                .copyWith(novelId: Value(novelId));

            batch.insert(_database.metaEntries, companion);
            log.finer(
                'insert meta entry ${state.data.name}: ${state.data.value}');
          },
          remove: (state) {
            batch.delete(_database.metaEntries, state.data);
            log.finer(
                'remove meta entry ${state.data.name}: ${state.data.value}');
          },
          replace: (state) {
            final companion = sourceMetaDataIntoCompanion(state.next).copyWith(
              id: Value(state.prev.id),
              novelId: Value(novelId),
            );

            batch.replace(_database.metaEntries, companion);
            log.finer(
                'replace meta entry ${state.next.name}: ${state.next.value}');
          },
          keep: (state) {
            log.finer(
                'keep meta entry ${state.next.name}: ${state.next.value}');
          },
        );
      }
    });
  }
}

@freezed
class UpdateResult with _$UpdateResult {
  factory UpdateResult({
    required bool isInitial,
    required int novelId,
    required List<int> insertedIds,
  }) = _UpdateResult;

  UpdateResult._();
}

class _ChapterWrapper {
  _ChapterWrapper(this.chapter, this.volumeId);

  final sources.Chapter chapter;
  final int volumeId;
}
