import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';

final assetRepositoryProvider = Provider<AssetRepository>(
  (ref) => AssetRepositoryImpl(
    database: ref.watch(databaseProvider),
  ),
  name: 'AssetRepositoryProvider',
);

abstract class AssetRepository {
  Future<Either<Failure, AssetData>> addAsset(
    String directory,
    AssetInfo data, [
    String? url,
  ]);

  Future<Either<Failure, AssetInfo>> downloadAsset(String url);

  Future<Either<Failure, void>> deleteAsset(AssetData asset);

  Future<Either<Failure, AssetData>> getAsset(int assetId);
}
