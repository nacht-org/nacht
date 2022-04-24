import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';

import '../../core/failure.dart';
import '../entities/entities.dart';
import '../entities/novel/novel_entity.dart';
import '../repositories/network_repository.dart';
import '../repositories/novel_repository.dart';

class ParseOrGetNovel {
  ParseOrGetNovel(
    this._remoteRepository,
    this._localRepository,
    this._networkRepository,
  );

  final NovelLocalRepository _localRepository;
  final NetworkRepository _networkRepository;
  final NovelRemoteRepository _remoteRepository;

  final _log = Logger('ParseOrGetNovel');

  Future<Either<Failure, NovelEntity>> execute(
    ParseNovel parser,
    String url,
  ) async {
    final isConnectionAvailable =
        await _networkRepository.isConnectionAvailable();
    _log.info('Is network connection available: $isConnectionAvailable.');

    if (isConnectionAvailable) {
      final parseResult = await _remoteRepository.parseNovel(parser, url);

      // TODO: download cover image

      return await parseResult.fold<Future<Either<Failure, NovelEntity>>>(
        (failure) async => Left(failure),
        (data) => _localRepository.saveNovel(data),
      );
    } else {
      return await _localRepository.getNovelByUrl(url);
    }
  }
}
