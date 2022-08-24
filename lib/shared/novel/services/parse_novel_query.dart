import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';

final parseNovelQueryProvider = Provider<ParseNovelQuery>(
  (ref) => ParseNovelQuery(
    database: ref.watch(databaseProvider),
  ),
  name: 'ParseNovelQueryProvider',
);

/// Parse the provided [query] by fetching metadata and chapters
/// from database as requried.
class ParseNovelQuery {
  ParseNovelQuery({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, NovelData>> execute(
    JoinedSelectStatement<HasResultSet, dynamic> query,
  ) async {
    final result = await query.getSingleOrNull();
    if (result == null) {
      return const Left(NovelNotFound());
    }

    final novel = result.readTable(_database.novels);
    final asset = result.readTableOrNull(_database.assets);

    final chapters = await _getChapterModels(novel.id);

    final entity = NovelData.fromModel(novel).copyWith(
      chapters: chapters,
      cover: asset == null ? null : AssetData.fromModel(asset),
    );

    return Right(entity);
  }

  Future<List<ChapterData>> _getChapterModels(
    int novelId,
  ) async {
    final query = _database.select(_database.chapters).join([
      leftOuterJoin(
        _database.volumes,
        _database.chapters.volumeId.equalsExp(_database.volumes.id),
      )
    ])
      ..where(_database.chapters.novelId.equals(novelId));

    final results = await query.get();

    return results.map((row) {
      final chapter = row.readTable(_database.chapters);
      final volume = row.readTable(_database.volumes);

      return ChapterData.fromModel(chapter, VolumeData.fromModel(volume));
    }).toList();
  }
}
