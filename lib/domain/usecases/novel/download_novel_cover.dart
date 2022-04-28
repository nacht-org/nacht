import 'package:chapturn/core/failure.dart';
import 'package:chapturn/data/failure.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/repositories/asset_repository.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:dartz/dartz.dart';

/// Potential failures
/// * [CoverNotAvailable] if novel has not cover.
/// * [NetworkNotAvailable] if internet connection is not available.
///
/// See also:
/// * [AssetRepository.downloadAsset]
/// * [AssetRepository.addAsset]
/// * [AssetRepository.deleteAsset]
class DownloadNovelCover {
  final NovelLocalRepository localRepository;
  final NetworkRepository networkRepository;
  final AssetRepository assetRepository;

  DownloadNovelCover({
    required this.localRepository,
    required this.networkRepository,
    required this.assetRepository,
  });

  /// See [DownloadNovelCover]
  Future<Either<Failure, AssetEntity>> execute(
    NovelEntity novel,
  ) async {
    if (novel.coverUrl == null) {
      return const Left(CoverNotAvailable());
    }

    var connected = await networkRepository.isConnectionAvailable();
    if (!connected) {
      return const Left(NetworkNotAvailable());
    }

    final companionResult =
        await assetRepository.downloadAsset(novel.coverUrl!);

    final assetResult =
        await companionResult.fold<Future<Either<Failure, AssetEntity>>>(
      (failure) async => Left(failure),
      (companion) async {
        if (novel.cover != null) {
          await assetRepository.deleteAsset(novel.cover!);
        }

        return await assetRepository.addAsset(companion);
      },
    );

    return assetResult.fold(
      (failure) async => Left(failure),
      (asset) async {
        await localRepository.setCover(novel.id, asset);
        return Right(asset);
      },
    );
  }
}
