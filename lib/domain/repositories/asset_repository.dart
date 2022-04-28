import 'package:chapturn/core/failure.dart';
import 'package:chapturn/data/datasources/local/database.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract class AssetRepository {
  Future<Either<Failure, AssetEntity>> addAsset(AssetsCompanion asset);
  Future<Either<Failure, AssetsCompanion>> downloadAsset(String url);
  Future<Either<Failure, void>> deleteAsset(AssetEntity asset);
}
