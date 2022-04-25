import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';

abstract class NovelRemoteRepository {
  Future<Either<Failure, Novel>> parseNovel(ParseNovel parser, String url);
}

abstract class NovelLocalRepository {
  Future<Either<Failure, NovelEntity>> getNovel(int id);
  Future<Either<Failure, NovelEntity>> getNovelByUrl(String url);
  Future<Either<Failure, NovelEntity>> saveNovel(Novel novel);
  Future<void> setFavourite(int novelId, bool value);
}
