import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chapturn_sources/src/models/novel.dart';
import 'package:chapturn_sources/src/interfaces/novel.dart';

class NovelRemoteRepositoryImpl implements NovelRemoteRepository {
  @override
  Future<Either<Failure, Novel>> parseNovel(
    ParseNovel parser,
    String url,
  ) async {
    // TODO: check for exceptions
    final novel = await parser.parseNovel(url);

    return Right(novel);
  }
}
