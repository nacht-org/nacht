import 'package:chapturn/domain/repositories/gateway_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

import '../../core/core.dart';

final chapterServiceProvider = Provider<ChapterService>(
  (ref) => ChapterService(
    gatewayRepository: ref.watch(gatewayRepositoryProvider),
  ),
  name: 'ChapterServiceProvider',
);

class ChapterService {
  ChapterService({
    required GatewayRepository gatewayRepository,
  }) : _gatewayRepository = gatewayRepository;

  final GatewayRepository _gatewayRepository;

  Future<Either<Failure, String>> fetchContent(
    sources.ParseNovel parser,
    String url,
  ) async {
    final chapter = await _gatewayRepository.parseChapter(parser, url);

    return chapter.fold(
      (failure) => Left(failure),
      (data) => Right(data.content!),
    );
  }
}
