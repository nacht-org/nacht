import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/failure.dart';
import 'package:chapturn/data/models/models.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

import '../../../core/core.dart';

class NovelLocalRepositoryImpl
    with LoggerMixin
    implements NovelLocalRepository {
  NovelLocalRepositoryImpl({
    required this.database,
    required this.novelCompanionMapper,
    required this.volumeCompanionMapper,
    required this.chapterCompanionMapper,
    required this.metadataCompanionMapper,
    required this.novelMapper,
    required this.volumeMapper,
    required this.chapterMapper,
    required this.metaDataMapper,
  });

  final AppDatabase database;

  final Mapper<sources.Novel, NovelsCompanion> novelCompanionMapper;
  final Mapper<sources.Volume, VolumesCompanion> volumeCompanionMapper;
  final Mapper<sources.Chapter, ChaptersCompanion> chapterCompanionMapper;
  final Mapper<sources.MetaData, MetaDatasCompanion> metadataCompanionMapper;

  final Mapper<Novel, NovelEntity> novelMapper;
  final Mapper<Volume, VolumeEntity> volumeMapper;
  final Mapper<Chapter, ChapterEntity> chapterMapper;
  final Mapper<MetaData, MetaDataEntity> metaDataMapper;

  @override
  Future<Either<Failure, NovelEntity>> getNovel(int id) async {
    final query = database.select(database.novels)
      ..where((tbl) => tbl.id.equals(id));

    return await _getNovel(query);
  }

  @override
  Future<Either<Failure, NovelEntity>> getNovelByUrl(String url) async {
    final query = database.select(database.novels)
      ..where((tbl) => tbl.url.equals(url));

    return await _getNovel(query);
  }

  Future<Either<Failure, NovelEntity>> _getNovel(
    SimpleSelectStatement<$NovelsTable, Novel> query,
  ) async {
    final novel = await query.getSingleOrNull();
    if (novel == null) {
      return const Left(NovelNotFound());
    }

    final metadata =
        (await getMetaData(novel.id)).map(metaDataMapper.from).toList();
    final volumes = await _getVolumesOfNovel(novel.id);

    final entity =
        novelMapper.from(novel).copyWith(volumes: volumes, metadata: metadata);

    return Right(entity);
  }

  Future<List<VolumeEntity>> _getVolumesOfNovel(
    int novelId,
  ) async {
    final query = database.select(database.volumes)
      ..where((tbl) => tbl.novelId.equals(novelId));
    final volumes = await query.get();

    final entities = <VolumeEntity>[];
    for (final volume in volumes) {
      final entity = volumeMapper
          .from(volume)
          .copyWith(chapters: await _getChaptersOfVolume(volume.id));
      entities.add(entity);
    }

    return entities;
  }

  Future<List<ChapterEntity>> _getChaptersOfVolume(
    int volumeId,
  ) async {
    final query = database.select(database.chapters)
      ..where((tbl) => tbl.volumeId.equals(volumeId));
    final result = await query.get();

    return result.map(chapterMapper.from).toList();
  }

  @override
  Future<Either<Failure, NovelEntity>> saveNovel(sources.Novel novel) async {
    final novelCompanion = novelCompanionMapper.from(novel);

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
      final volumeCompanion = volumeCompanionMapper
          .from(volume)
          .copyWith(novelId: Value(novelModel.id));

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
        final chapterCompanion = chapterCompanionMapper
            .from(chapter)
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

    final novelEntity = novelMapper.from(novelModel).copyWith(
          volumes: volumes.entries
              .map(
                (entry) => volumeMapper.from(entry.key).copyWith(
                      chapters: entry.value
                          .map((c) => chapterMapper
                              .from(c)
                              .copyWith(volumeId: entry.key.id))
                          .toList(),
                      novelId: novelModel.id,
                    ),
              )
              .toList(),
          metadata: (await getMetaData(novelModel.id))
              .map(metaDataMapper.from)
              .toList(),
        );

    return Right(novelEntity);
  }

  // MetaData.

  Future<List<MetaData>> getMetaData(int novelId) async {
    final query = database.select(database.metaDatas)
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
      final toAdd = <MetaDatasCompanion>[];

      // Check for required updates.
      for (final data in metaData) {
        final companion = metadataCompanionMapper
            .from(data)
            .copyWith(novelId: Value(novelId));

        final key = Tuple2(data.name, data.value);
        if (indexedMetaData.containsKey(key)) {
          final currentData = indexedMetaData.remove(key)!;

          if (currentData.others != companion.others.value) {
            batch.replace(
              database.metaDatas,
              companion.copyWith(id: Value(currentData.id)),
            );
          }
        } else {
          toAdd.add(companion);
        }
      }

      // Add all the new metadata.
      batch.insertAll(database.metaDatas, toAdd);

      // Delete those that are no longer associated with novel.
      batch.deleteWhere(
          database.metaDatas,
          (tbl) => (tbl as MetaDatas)
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
  Future<void> setCover(int novelId, AssetEntity asset) async {
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
