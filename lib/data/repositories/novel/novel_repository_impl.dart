import 'dart:convert';

import 'package:nacht/data/misc/wrappers.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';
import '../../failure.dart';
import '../../../database/misc/companion_utils.dart';

class NovelRepositoryImpl with LoggerMixin implements NovelRepository {
  NovelRepositoryImpl({
    required this.database,
  });

  final AppDatabase database;

  @override
  Future<Either<Failure, NovelData>> getNovel(int id) async {
    final query = database.select(database.novels).join([
      leftOuterJoin(
        database.assets,
        database.assets.id.equalsExp(database.novels.coverId),
      ),
    ])
      ..where(database.novels.id.equals(id));

    return await _getNovel(query);
  }

  @override
  Future<Either<Failure, NovelData>> getNovelByUrl(String url) async {
    final query = database.select(database.novels).join([
      leftOuterJoin(
        database.assets,
        database.assets.id.equalsExp(database.novels.coverId),
      ),
    ])
      ..where(database.novels.url.equals(url));

    return await _getNovel(query);
  }

  Future<Either<Failure, NovelData>> _getNovel(
    JoinedSelectStatement<HasResultSet, dynamic> query,
  ) async {
    final result = await query.getSingleOrNull();
    if (result == null) {
      return const Left(NovelNotFound());
    }

    final novel = result.readTable(database.novels);
    final asset = result.readTableOrNull(database.assets);

    final metadata =
        (await getMetaData(novel.id)).map(MetaEntryData.fromModel).toList();
    final chapters = await _getChapterModels(novel.id);

    final entity = NovelData.fromModel(novel).copyWith(
      chapters: chapters,
      metadata: metadata,
      cover: asset == null ? null : AssetData.fromModel(asset),
    );

    return Right(entity);
  }

  Future<List<ChapterData>> _getChapterModels(
    int novelId,
  ) async {
    final query = database.select(database.chapters).join([
      leftOuterJoin(
        database.volumes,
        database.chapters.volumeId.equalsExp(database.volumes.id),
      )
    ])
      ..where(database.chapters.novelId.equals(novelId));

    final results = await query.get();

    return results.map((row) {
      final chapter = row.readTable(database.chapters);
      final volume = row.readTable(database.volumes);

      return ChapterData.fromModel(chapter, VolumeData.fromModel(volume));
    }).toList();
  }

  Future<List<Chapter>> _getChapters(int novelId) async {
    final query = database.select(database.chapters)
      ..where((tbl) => tbl.novelId.equals(novelId));
    return await query.get();
  }

  @override
  Future<Either<Failure, UpdateResult>> updateNovel(sources.Novel novel) async {
    log.fine('starting novel update');

    final novelCompanion = novelIntoCompanion(novel);

    UpdateResult result = UpdateResult(initial: true, novel: -1, inserted: []);

    await database.transaction(() async {
      // Upsert the novel entity itself
      final currentNovel = await (database.select(database.novels)
            ..where((tbl) => tbl.url.equals(novelCompanion.url.value)))
          .getSingleOrNull();
      result = result.copyWith(initial: currentNovel == null);
      if (result.initial) {
        final id = await database.into(database.novels).insert(novelCompanion);
        result = result.copyWith(novel: id);
      } else {
        await (database.update(database.novels)
              ..where((tbl) => tbl.id.equals(currentNovel!.id)))
            .write(novelCompanion);

        result = result.copyWith(novel: currentNovel!.id);
      }

      // Update volumes and chapters (editing, removing)
      final inserts = await syncVolumes(result.novel, novel.volumes);

      // Insert chapters.
      log.fine('inserting chapters');
      final insertedIds = <int>[];
      for (final companion in inserts) {
        final id = await database.into(database.chapters).insert(companion);
        insertedIds.add(id);
      }

      result = result.copyWith(inserted: insertedIds);

      // Update metadata.
      await syncMetaData(result.novel, novel.metadata);
    });

    // FIXME: handle where transaction failed

    log.fine('ending novel update');

    return Right(result);
  }

  Future<List<ChaptersCompanion>> syncVolumes(
    int novelId,
    List<sources.Volume> volumes,
  ) async {
    final insertCompanions = <ChaptersCompanion>[];

    log.fine('syncing volumes');
    final volumeModels = <Volume, List<sources.Chapter>>{};
    for (final volume in volumes) {
      final volumeCompanion =
          volumeIntoCompanion(volume).copyWith(novelId: Value(novelId));

      final model =
          await database.into(database.volumes).insertReturning(volumeCompanion,
              onConflict: DoUpdate(
                (old) => volumeCompanion,
                target: [
                  database.volumes.novelId,
                  database.volumes.volumeIndex
                ],
              ));

      volumeModels[model] = volume.chapters;
    }

    final newChapters = <SourceChapterWrapper>[];
    for (final entry in volumeModels.entries) {
      newChapters.addAll(
        entry.value
            .map((chapter) => SourceChapterWrapper(chapter, entry.key.id)),
      );
    }

    final currentChapters = await _getChapters(novelId);

    log.fine('updating and removing chapters');
    await database.batch((batch) async {
      final diff = calculateDiff<Chapter, SourceChapterWrapper>(
        prev: IdentityList<Chapter, String>(
          items: currentChapters,
          identity: (item) => item.url,
        ),
        next: IdentityList<SourceChapterWrapper, String>(
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
                chapterIntoCompanion(next.chapter).copyWith(
              volumeId: Value(next.volumeId),
              novelId: Value(novelId),
            );

            insertCompanions.add(chapterCompanion);
            log.finer(
                'insert chapter ${next.chapter.index} ${next.chapter.title}');
          },
          remove: (prev) {
            batch.delete(database.chapters, prev);
            log.finer('remove chapter ${prev.chapterIndex} ${prev.title}');
          },
          replace: (prev, next) {
            final chapterCompanion =
                chapterIntoCompanion(next.chapter).copyWith(
              id: Value(prev.id),
              volumeId: Value(next.volumeId),
            );

            batch.replace(database.chapters, chapterCompanion);
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

  // MetaData.

  Future<List<MetaEntry>> getMetaData(int novelId) async {
    final query = database.select(database.metaEntries)
      ..where((tbl) => tbl.novelId.equals(novelId));

    return await query.get();
  }

  Future<void> syncMetaData(
    int novelId,
    List<sources.MetaData> metaData,
  ) async {
    log.info('syncing metadata.');

    final diff = calculateDiff<MetaEntry, sources.MetaData>(
      prev: IdentityList<MetaEntry, Tuple2>(
        items: await getMetaData(novelId),
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

    await database.batch((batch) {
      for (final change in diff) {
        change.map(
          insert: (state) {
            final companion = metaDataIntoCompanion(state.data)
                .copyWith(novelId: Value(novelId));

            batch.insert(database.metaEntries, companion);
            log.finer(
                'insert meta entry ${state.data.name}: ${state.data.value}');
          },
          remove: (state) {
            batch.delete(database.metaEntries, state.data);
            log.finer(
                'remove meta entry ${state.data.name}: ${state.data.value}');
          },
          replace: (state) {
            final companion = metaDataIntoCompanion(state.next).copyWith(
              id: Value(state.prev.id),
              novelId: Value(novelId),
            );

            batch.replace(database.metaEntries, companion);
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

  // No side effects

  /// Failures:
  /// - [SelectFailure], when there is no unread chapter
  @override
  Future<Either<Failure, ChapterData>> firstUnread(int novelId) async {
    final query = database.select(database.chapters).join([
      leftOuterJoin(
        database.volumes,
        database.volumes.id.equalsExp(database.chapters.volumeId),
      ),
      leftOuterJoin(
        database.novels,
        database.novels.id.equalsExp(database.chapters.novelId),
        useColumns: false,
      )
    ])
      ..where(database.novels.id.equals(novelId) &
          database.chapters.readAt.isNull())
      ..orderBy([OrderingTerm.asc(database.chapters.chapterIndex)])
      ..limit(1);

    final row = await query.getSingleOrNull();
    if (row == null) {
      return Left(SelectFailure());
    }

    final chapter = row.readTable(database.chapters);
    final volume = row.readTable(database.volumes);

    return Right(ChapterData.fromModel(chapter, VolumeData.fromModel(volume)));
  }

  // Single field updates.

  @override
  Future<void> setFavourite(int novelId, bool value) async {
    final companion = NovelsCompanion(
      id: Value(novelId),
      favourite: Value(value),
    );

    log.fine('set novel favourite to $value');
    await _update(companion);
  }

  @override
  Future<void> setCover(int novelId, AssetData asset) async {
    final companion = NovelsCompanion(
      id: Value(novelId),
      coverId: Value(asset.id),
    );

    await _update(companion);
  }

  Future<void> _update(NovelsCompanion companion) async {
    final statement = database.update(database.novels)
      ..whereSamePrimaryKey(companion);

    await statement.write(companion);
  }
}
