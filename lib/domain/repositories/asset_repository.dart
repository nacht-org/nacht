import 'package:chapturn/core/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract class AssetRepository {
  Future<Either<Failure, AssetEntity>> addAsset(
    String directory,
    AssetData data, [
    String? url,
  ]);

  Future<Either<Failure, AssetData>> downloadAsset(String url);

  Future<Either<Failure, void>> deleteAsset(AssetEntity asset);

  Future<Either<Failure, AssetEntity>> getAsset(int assetId);
}
