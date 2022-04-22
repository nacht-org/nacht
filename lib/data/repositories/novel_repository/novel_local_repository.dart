import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/failure.dart';
import 'package:chapturn/domain/entities/chapter_entity.dart';
import 'package:chapturn/domain/entities/novel_entity.dart';
import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/volume_entity.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

class NovelLocalRepositoryImpl implements NovelLocalRepository {
  NovelLocalRepositoryImpl({
    required this.database,
    required this.novelMapper,
    required this.volumeMapper,
    required this.chapterMapper,
  });

  final AppDatabase database;
  final Mapper<Novel, NovelEntity> novelMapper;
  final Mapper<Volume, VolumeEntity> volumeMapper;
  final Mapper<Chapter, ChapterEntity> chapterMapper;

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

    final entity = novelMapper
        .map(novel)
        .copyWith(volumes: await _getVolumesOfNovel(novel.id));

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
          .map(volume)
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

    return result.map(chapterMapper.map).toList();
  }

  @override
  Future<Either<Failure, int>> saveNovel(Novel novel) async {
    // TODO: check for error?
    final id = await database
        .into(database.novels)
        .insert(novel, onConflict: DoUpdate((old) => novel));

    return Right(id);
  }
}
