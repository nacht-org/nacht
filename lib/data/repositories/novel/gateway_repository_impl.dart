import 'package:chapturn/core/failure.dart';
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
}
