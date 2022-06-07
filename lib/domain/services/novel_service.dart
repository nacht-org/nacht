import 'package:nacht/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/failure.dart';
import '../domain.dart';

final novelServiceProvider = Provider<NovelService>(
  (ref) => NovelService(
    novelRepository: ref.watch(novelRepositoryProvider),
    assetRepository: ref.watch(assetRepositoryProvider),
    networkRepository: ref.watch(networkRepositoryProvider),
    gatewayRepository: ref.watch(gatewayRepositoryProvider),
    updatesRepository: ref.watch(updatesRepositoryProvider),
  ),
  name: 'NovelServiceProvider',
);

class NovelService with LoggerMixin {
  NovelService({
    required NovelRepository novelRepository,
    required AssetRepository assetRepository,
    required NetworkRepository networkRepository,
    required GatewayRepository gatewayRepository,
    required UpdatesRepository updatesRepository,
  })  : _novelRepository = novelRepository,
        _assetRepository = assetRepository,
        _networkRepository = networkRepository,
        _gatewayRepository = gatewayRepository,
        _updatesRepository = updatesRepository;

  final NovelRepository _novelRepository;
  final AssetRepository _assetRepository;
  final NetworkRepository _networkRepository;
  final GatewayRepository _gatewayRepository;
  final UpdatesRepository _updatesRepository;

  Future<Either<Failure, NovelData>> getById(int id) {
    return _novelRepository.getNovel(id);
  }

  Future<Either<Failure, NovelData>> parseOrGet(
    sources.ParseNovel parser,
    String url,
  ) async {
    final isConnectionAvailable =
        await _networkRepository.isConnectionAvailable();

    if (isConnectionAvailable) {
      final parseResult = await _gatewayRepository.parseNovel(parser, url);

      final updateResult =
          await parseResult.fold<Future<Either<Failure, UpdateResult>>>(
        (failure) async => Left(failure),
        (data) => _novelRepository.updateNovel(data),
      );

      final insertResult =
          await updateResult.fold<Future<Either<Failure, void>>>(
        (failure) async => Left(failure),
        (data) async {
          if (!data.initial) {
            return await _updatesRepository
                .addAll(data.intoNewUpdates().reversed);
          }

          return const Right(null);
        },
      );

      final failure = insertResult.getLeft();
      if (failure != null) {
        return Left(failure);
      }
    }

    return await _novelRepository.getNovelByUrl(url);
  }

  Future<Either<Failure, AssetData>> downloadCover(NovelData novel) async {
    if (novel.coverUrl == null) {
      return const Left(CoverNotAvailable());
    }

    var connected = await _networkRepository.isConnectionAvailable();
    if (!connected) {
      return const Left(NetworkNotAvailable());
    }

    final dataResult = await _assetRepository.downloadAsset(novel.coverUrl!);

    final assetResult =
        await dataResult.fold<Future<Either<Failure, AssetData>>>(
      (failure) async => Left(failure),
      (data) async {
        if (novel.cover != null) {
          if (novel.cover!.hash == data.hash) {
            log.fine('asset save skipped, has the same content');
            return const Left(SameAssetError());
          }

          await _assetRepository.deleteAsset(novel.cover!);
        }

        log.fine('saving asset');
        return await _assetRepository.addAsset(
            novel.id.toString(), data, novel.coverUrl);
      },
    );

    return assetResult.fold(
      (failure) async => Left(failure),
      (asset) async {
        await _novelRepository.setCover(novel.id, asset);
        return Right(asset);
      },
    );
  }

  Future<Either<Failure, ChapterData>> firstUnread(int novelId) {
    return _novelRepository.firstUnread(novelId);
  }
}
