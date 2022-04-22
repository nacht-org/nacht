import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/novel_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:chapturn/data/datasources/local/database.dart' as db;

abstract class NovelRemoteRepository {
  Future<Either<Failure, Novel>> parseNovel(ParseNovel parser, String url);
}

abstract class NovelLocalRepository {
  Future<Either<Failure, NovelEntity>> getNovel(int id);
  Future<Either<Failure, NovelEntity>> getNovelByUrl(String url);
  Future<Either<Failure, int>> saveNovel(db.Novel novel);
}
