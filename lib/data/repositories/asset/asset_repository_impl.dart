import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../core/failure.dart';
import '../../../core/core.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/mapper.dart';
import '../../../domain/repositories/asset_repository.dart';
import '../../datasources/local/database.dart';
import '../../failure.dart';

class AssetRepositoryImpl with LoggerMixin implements AssetRepository {
  AssetRepositoryImpl({
    required this.database,
    required this.mimeTypeToSeedMapper,
    required this.databaseToAssetMapper,
  });

  final AppDatabase database;
  final Mapper<String, int> mimeTypeToSeedMapper;
  final Mapper<Asset, AssetEntity> databaseToAssetMapper;

  /// Possible failures:
  /// * [UnknownAssetType]
  /// * [FileSaveError]
  @override
  Future<Either<Failure, AssetEntity>> addAsset(
    String directory,
    AssetData data, [
    String? url,
  ]) async {
    int assetType;
    try {
      assetType = mimeTypeToSeedMapper.from(data.mimetype);
    } catch (e) {
      return const Left(UnknownAssetType());
    }

    final insert = AssetsCompanion.insert(
      url: Value(url),
      hash: data.hash,
      typeId: assetType,
    );

    final assetId = await database.into(database.assets).insert(insert);
    final documentDirectory = await getTemporaryDirectory();

    final assetName = '$assetId.${data.mimetype.split("/").last}';
    final assetPath = path.join(documentDirectory.path, directory, assetName);
    final companion =
        AssetsCompanion(id: Value(assetId), path: Value(assetPath));

    File assetFile;
    try {
      assetFile = File(assetPath)..create(recursive: true);
      await assetFile.writeAsBytes(data.bytes);

      await _update(companion);
    } catch (e) {
      log.fine('failed to save asset type ${data.mimetype}');
      await (database.delete(database.assets)..whereSamePrimaryKey(companion))
          .go();
      return const Left(FileSaveError());
    }

    log.fine("saved asset into $assetPath.");

    return Right(AssetEntity(
      id: assetId,
      url: url,
      file: assetFile,
      hash: data.hash,
      mimetype: data.mimetype,
    ));
  }

  @override
  Future<Either<Failure, void>> deleteAsset(AssetEntity asset) {
    // TODO: implement deleteAsset
    throw UnimplementedError();
  }

  /// Possible failures:
  /// * [DownloadFailed]
  @override
  Future<Either<Failure, AssetData>> downloadAsset(String url) async {
    Response response;
    try {
      response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          validateStatus: (status) => status == 200,
        ),
      );
    } catch (e) {
      return Left(DownloadFailed(e.toString()));
    }

    String mimetype;
    try {
      mimetype = response.headers['content-type']!.single;
    } catch (e) {
      return const Left(
        DownloadFailed('Did not recieve a mimetype for the file.'),
      );
    }

    final hash = sha1.convert(response.data).toString();

    return Right(AssetData(response.data, mimetype, hash));
  }

  Future<void> _update(AssetsCompanion companion) async {
    final statement = database.update(database.assets)
      ..whereSamePrimaryKey(companion);

    await statement.write(companion);
  }

  /// Possible failures:
  /// * [AssetNotFound]
  @override
  Future<Either<Failure, AssetEntity>> getAsset(int assetId) async {
    final query = database.select(database.assets)
      ..where((tbl) => tbl.id.equals(assetId));

    try {
      final asset = await query.getSingle();
      return Right(databaseToAssetMapper.from(asset));
    } catch (e) {
      return const Left(AssetNotFound());
    }
  }
}
