import 'package:nacht/core/core.dart';
import 'package:nacht/data/data.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../domain.dart';

final novelRepositoryProvider = Provider<NovelRepository>(
  (ref) => NovelRepositoryImpl(
    database: ref.watch(databaseProvider),
  ),
  name: 'NovelRepositoryProvider',
);

abstract class NovelRepository {
  Future<Either<Failure, NovelData>> getNovel(int id);
  Future<Either<Failure, NovelData>> getNovelByUrl(String url);
  Future<Either<Failure, UpdateResult>> updateNovel(sources.Novel novel);
  Future<Either<Failure, ChapterData>> firstUnread(int novelId);

  Future<void> setFavourite(int novelId, bool value);
  Future<void> setCover(int novelId, AssetData asset);
}
