import 'package:nacht/core/failure.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:dartz/dartz.dart';

import '../../../domain/domain.dart';

class GatewayRepositoryImpl implements GatewayRepository {
  @override
  Future<Either<Failure, sources.Novel>> parseNovel(
    sources.ParseNovel parser,
    String url,
  ) async {
    // TODO: check for exceptions
    final novel = await parser.parseNovel(url);

    return Right(novel);
  }

  @override
  Future<Either<Failure, sources.Chapter>> parseChapter(
      sources.ParseNovel parser, String url) async {
    // TODO: test
    final chapter = sources.Chapter(title: '', url: url, index: -1);

    // TODO: check for parseChapter
    await parser.parseChapter(chapter);

    return Right(chapter);
  }
}
