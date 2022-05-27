import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../../core/core.dart';
import '../domain.dart';

final chapterServiceProvider = Provider<ChapterService>(
  (ref) => ChapterService(
    gatewayRepository: ref.watch(gatewayRepositoryProvider),
    chapterRepository: ref.watch(chapterRepositoryProvider),
  ),
  name: 'ChapterServiceProvider',
);

class ChapterService {
  ChapterService({
    required ChapterRepository chapterRepository,
    required GatewayRepository gatewayRepository,
  })  : _chapterRepository = chapterRepository,
        _gatewayRepository = gatewayRepository;

  final ChapterRepository _chapterRepository;
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

  Future<Either<Failure, void>> setReadAt(
      List<ChapterData> chapters, bool isRead) {
    final readAt = isRead ? DateTime.now() : null;
    return _chapterRepository.setReadAt(chapters, readAt);
  }
}
