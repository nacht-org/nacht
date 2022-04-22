import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/novel_entity.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:chapturn/data/datasources/local/database.dart' as db;

import '../mapper.dart';

class ParseOrGetNovel {
  ParseOrGetNovel(
    this._remoteRepository,
    this._localRepository,
    this._networkRepository,
    this.sourceToDatabaseMapper,
  );

  final NovelLocalRepository _localRepository;
  final NetworkRepository _networkRepository;
  final NovelRemoteRepository _remoteRepository;

  final Mapper<Novel, db.Novel> sourceToDatabaseMapper;

  Future<Either<Failure, NovelEntity>> execute(
    ParseNovel parser,
    String url,
  ) async {
    final isConnectionAvailable =
        await _networkRepository.isConnectionAvailable();
    if (isConnectionAvailable) {
      final parseResult = await _remoteRepository.parseNovel(parser, url);

      final updateResult = await parseResult.fold<Future<Either<Failure, int>>>(
        (failure) async => Left(failure),
        (data) {
          final model = sourceToDatabaseMapper.map(data);
          return _localRepository.saveNovel(model);
        },
      );

      return await updateResult.fold<Future<Either<Failure, NovelEntity>>>(
        (failure) async => Left(failure),
        (data) => _localRepository.getNovel(data),
      );
    } else {
      return await _localRepository.getNovelByUrl(url);
    }
  }
}
