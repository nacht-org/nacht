import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';
import '../../failure.dart';
import '../../misc/into_companion.dart';

class NovelRepositoryImpl with LoggerMixin implements NovelRepository {
  NovelRepositoryImpl({
    required this.database,
  });

  final AppDatabase database;

  @override
  Future<Either<Failure, NovelData>> getNovel(int id) async {
    final query = database.select(database.novels)
      ..where((tbl) => tbl.id.equals(id));

    return await _getNovel(query);
  }

  @override
  Future<Either<Failure, NovelData>> getNovelByUrl(String url) async {
    final query = database.select(database.novels)
      ..where((tbl) => tbl.url.equals(url));

    return await _getNovel(query);
  }

  Future<Either<Failure, NovelData>> _getNovel(
    SimpleSelectStatement<$NovelsTable, Novel> query,
  ) async {
    final novel = await query.getSingleOrNull();
    if (novel == null) {
      return const Left(NovelNotFound());
    }

    final metadata = (await getMetaData(novel.id))
        .map((value) => MetaEntryData.fromModel(value))
        .toList();
    final volumes = await _getVolumesOfNovel(novel.id);

    final entity = NovelData.fromModel(novel)
        .copyWith(volumes: volumes, metadata: metadata);

    return Right(entity);
  }

  Future<List<VolumeData>> _getVolumesOfNovel(
    int novelId,
  ) async {
    final query = database.select(database.volumes)
      ..where((tbl) => tbl.novelId.equals(novelId));
    final volumes = await query.get();

    final entities = <VolumeData>[];
    for (final volume in volumes) {
      final entity = VolumeData.fromModel(volume)
          .copyWith(chapters: await _getChapterModelsOfVolume(volume.id));
      entities.add(entity);
    }

    return entities;
  }

  Future<List<ChapterData>> _getChapterModelsOfVolume(
    int volumeId,
  ) async {
    return (await _getChaptersOfVolume(volumeId))
        .map(ChapterData.fromModel)
        .toList();
  }

  Future<List<Chapter>> _getChaptersOfVolume(int volumeId) async {
    final query = database.select(database.chapters)
      ..where((tbl) => tbl.volumeId.equals(volumeId));
    return await query.get();
  }

  @override
  Future<Either<Failure, List<int>>> updateNovel(sources.Novel novel) async {
    log.fine('starting novel update');

    final novelCompanion = novelIntoCompanion(novel);

    // Upsert the novel entity itself
    final novelModel = await database.into(database.novels).insertReturning(
          novelCompanion,
          onConflict: DoUpdate(
            (old) => novelCompanion,
            target: [database.novels.url],
          ),
        );

    List<int>? insertedIds;

    await database.transaction(() async {
      // Update volumes and chapters (editing, removing)
      final inserts = await syncVolumes(novelModel.id, novel.volumes);

      // Insert chapters.
      log.fine('inserting chapters');
      insertedIds = await Future.wait(inserts.map(
        (companion) => database.into(database.chapters).insert(companion),
      ));

      // Update metadata.
      await syncMetaData(novelModel.id, novel.metadata);
    });

    // FIXME: handle where transaction failed

    log.fine('ending novel update');

    return Right(insertedIds!);
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

    log.fine('updating and removing chapters');
    await database.batch((batch) async {
      for (final entry in volumeModels.entries) {
        final volume = entry.key;
        final chapters = entry.value;

        final diff = calculateDiff<Chapter, sources.Chapter>(
          prev: IdentityList<Chapter, String>(
            items: await _getChaptersOfVolume(volume.id),
            identity: (item) => item.url,
          ),
          next: IdentityList<sources.Chapter, String>(
            items: chapters,
            identity: (item) => item.url,
          ),
          equality: (prev, next) {
            return prev.title == next.title &&
                prev.updated == next.updated &&
                prev.chapterIndex == next.index;
          },
        );

        for (final change in diff) {
          change.map(
            insert: (state) async {
              final chapterCompanion = chapterIntoCompanion(state.data)
                  .copyWith(volumeId: Value(volume.id));

              insertCompanions.add(chapterCompanion);
              log.finer(
                  'insert chapter ${state.data.index} ${state.data.title}');
            },
            remove: (state) {
              batch.delete(database.chapters, state.data);
              log.finer(
                  'remove chapter ${state.data.chapterIndex} ${state.data.title}');
            },
            replace: (state) {
              final chapterCompanion =
                  chapterIntoCompanion(state.next).copyWith(
                id: Value(state.prev.id),
                volumeId: Value(volume.id),
                content: const Value.absent(),
              );

              batch.replace(database.chapters, chapterCompanion);
              log.finer(
                  'replace chapter ${state.next.index} ${state.next.title}');
            },
            keep: (state) {
              log.finer('keep chapter ${state.next.index} ${state.next.title}');
            },
          );
        }
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
    log.info('Start metadata sync.');

    final currentMetaData = await getMetaData(novelId);
    final indexedMetaData = {
      for (final data in currentMetaData) Tuple2(data.name, data.value): data
    };

    await database.batch((batch) {
      final toAdd = <MetaEntriesCompanion>[];

      // Check for required updates.
      for (final data in metaData) {
        final companion =
            metaDataIntoCompanion(data).copyWith(novelId: Value(novelId));

        final key = Tuple2(data.name, data.value);
        if (indexedMetaData.containsKey(key)) {
          final currentData = indexedMetaData.remove(key)!;

          if (currentData.others != companion.others.value) {
            batch.replace(
              database.metaEntries,
              companion.copyWith(id: Value(currentData.id)),
            );
          }
        } else {
          toAdd.add(companion);
        }
      }

      // Add all the new metadata.
      batch.insertAll(database.metaEntries, toAdd);

      // Delete those that are no longer associated with novel.
      batch.deleteWhere(
          database.metaEntries,
          (tbl) => (tbl as MetaEntries)
              .id
              .isIn(indexedMetaData.values.map((data) => data.id)));
    });

    log.info('End metadata sync.');
  }

  // Single field updates.

  @override
  Future<void> setFavourite(int novelId, bool value) async {
    final companion = NovelsCompanion(
      id: Value(novelId),
      favourite: Value(value),
    );

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
