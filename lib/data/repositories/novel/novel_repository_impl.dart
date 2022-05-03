import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../datasources/local/database.dart';
import '../../failure.dart';
import '../../misc/into_companion.dart';
import '../../models/models.dart';

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
          .copyWith(chapters: await _getChaptersOfVolume(volume.id));
      entities.add(entity);
    }

    return entities;
  }

  Future<List<ChapterData>> _getChaptersOfVolume(
    int volumeId,
  ) async {
    final query = database.select(database.chapters)
      ..where((tbl) => tbl.volumeId.equals(volumeId));
    final result = await query.get();

    return result.map(ChapterData.fromModel).toList();
  }

  @override
  Future<Either<Failure, NovelData>> saveNovel(sources.Novel novel) async {
    final novelCompanion = novelIntoCompanion(novel);

    // Upsert the novel entity itself
    final novelModel = await database.into(database.novels).insertReturning(
          novelCompanion,
          onConflict: DoUpdate(
            (old) => novelCompanion,
            target: [database.novels.url],
          ),
        );

    // Update volumes and chapters
    novel.volumes.sort((a, b) => a.index.compareTo(b.index));
    final volumes = <Volume, List<Chapter>>{};
    for (final volume in novel.volumes) {
      final volumeCompanion =
          volumeIntoCompanion(volume).copyWith(novelId: Value(novelModel.id));

      final volumeModel =
          await database.into(database.volumes).insertReturning(volumeCompanion,
              onConflict: DoUpdate(
                (old) => volumeCompanion,
                target: [
                  database.volumes.novelId,
                  database.volumes.volumeIndex
                ],
              ));

      final chapters = <Chapter>[];
      for (final chapter in volume.chapters) {
        final chapterCompanion = chapterIntoCompanion(chapter)
            .copyWith(volumeId: Value(volumeModel.id));

        final chapterModel = await database
            .into(database.chapters)
            .insertReturning(
              chapterCompanion,
              onConflict: DoUpdate(
                // Remove the content field null value to prevent overriding
                // current saved content.
                (old) =>
                    chapterCompanion.copyWith(content: const Value.absent()),
                target: [database.chapters.volumeId, database.chapters.url],
              ),
            );

        chapters.add(chapterModel);
      }

      volumes[volumeModel] = chapters;
    }

    // Update metadata.
    await syncMetaData(novelModel.id, novel.metadata);

    final novelEntity = NovelData.fromModel(novelModel).copyWith(
      volumes: volumes.entries
          .map(
            (entry) => VolumeData.fromModel(entry.key).copyWith(
              chapters: entry.value
                  .map((c) =>
                      ChapterData.fromModel(c).copyWith(volumeId: entry.key.id))
                  .toList(),
              novelId: novelModel.id,
            ),
          )
          .toList(),
      metadata: (await getMetaData(novelModel.id))
          .map((data) => MetaEntryData.fromModel(data))
          .toList(),
    );

    return Right(novelEntity);
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
