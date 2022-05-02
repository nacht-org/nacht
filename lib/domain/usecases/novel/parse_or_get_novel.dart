import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../../core/failure.dart';
import '../../entities/entities.dart';
import '../../entities/novel/novel_entity.dart';
import '../../repositories/network_repository.dart';
import '../../repositories/novel_repository.dart';

class ParseOrGetNovel with LoggerMixin {
  ParseOrGetNovel({
    required this.remoteRepository,
    required this.localRepository,
    required this.networkRepository,
  });

  final NovelLocalRepository localRepository;
  final NetworkRepository networkRepository;
  final NovelRemoteRepository remoteRepository;

  Future<Either<Failure, NovelEntity>> execute(
    ParseNovel parser,
    String url,
  ) async {
    final isConnectionAvailable =
        await networkRepository.isConnectionAvailable();

    if (isConnectionAvailable) {
      final parseResult = await remoteRepository.parseNovel(parser, url);

      return await parseResult.fold<Future<Either<Failure, NovelEntity>>>(
        (failure) async => Left(failure),
        (data) => localRepository.saveNovel(data),
      );
    } else {
      return await localRepository.getNovelByUrl(url);
    }
  }
}
