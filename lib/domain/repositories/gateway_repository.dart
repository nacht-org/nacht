import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/failure.dart';
import '../../data/data.dart';

final gatewayRepositoryProvider = Provider<GatewayRepository>(
  (ref) => GatewayRepositoryImpl(),
  name: 'GatewayRepositoryProvider',
);

abstract class GatewayRepository {
  Future<Either<Failure, sources.Novel>> parseNovel(
    sources.ParseNovel parser,
    String url,
  );

  Future<Either<Failure, sources.Chapter>> parseChapter(
    sources.ParseNovel parser,
    String url,
  );
}
