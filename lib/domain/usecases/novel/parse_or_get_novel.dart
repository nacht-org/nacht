import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/domain/repositories/asset_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';

import '../../../core/failure.dart';
import '../../entities/entities.dart';
import '../../entities/novel/novel_entity.dart';
import '../../repositories/network_repository.dart';
import '../../repositories/novel_repository.dart';

class ParseOrGetNovel {
  ParseOrGetNovel({
    required this.remoteRepository,
    required this.localRepository,
    required this.networkRepository,
  });

  final NovelLocalRepository localRepository;
  final NetworkRepository networkRepository;
  final NovelRemoteRepository remoteRepository;

  final _log = Logger('ParseOrGetNovel');

  Future<Either<Failure, NovelEntity>> execute(
    ParseNovel parser,
    String url,
  ) async {
    final isConnectionAvailable =
        await networkRepository.isConnectionAvailable();
    _log.info('Is network connection available: $isConnectionAvailable.');

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
