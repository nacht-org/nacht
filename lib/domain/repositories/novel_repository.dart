import 'package:chapturn/core/core.dart';
import 'package:chapturn/data/data.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

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
  Future<void> setFavourite(int novelId, bool value);
  Future<void> setCover(int novelId, AssetData asset);
}
