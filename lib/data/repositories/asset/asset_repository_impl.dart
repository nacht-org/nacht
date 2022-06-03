import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../core/failure.dart';
import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../domain/repositories/asset_repository.dart';
import '../../data.dart';
import '../../failure.dart';

class AssetRepositoryImpl with LoggerMixin implements AssetRepository {
  AssetRepositoryImpl({
    required this.database,
  });

  final AppDatabase database;

  /// Possible failures:
  /// * [UnknownAssetType]
  /// * [FileSaveError]
  @override
  Future<Either<Failure, AssetData>> addAsset(
    String directory,
    AssetInfo data, [
    String? url,
  ]) async {
    int assetType;
    try {
      assetType = AssetTypeSeed.fromMimeType(data.mimetype);
    } catch (e) {
      return const Left(UnknownAssetType());
    }

    final insert = AssetsCompanion.insert(
      url: Value(url),
      hash: data.hash,
      typeId: assetType,
    );

    final assetId = await database.into(database.assets).insert(insert);
    final cacheDirectory = await getTemporaryDirectory();

    final assetName = '$assetId.${data.mimetype.split("/").last}';
    final assetPath = path.join(cacheDirectory.path, directory, assetName);
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

    return Right(AssetData(
      id: assetId,
      url: url,
      file: assetFile,
      hash: data.hash,
      mimetype: data.mimetype,
    ));
  }

  @override
  Future<Either<Failure, void>> deleteAsset(AssetData asset) async {
    try {
      await asset.file.delete();
      await (database.delete(database.assets)
            ..where((tbl) => tbl.id.equals(asset.id)))
          .go();
    } catch (e) {
      return Left(AssetDeleteFailure(e.toString()));
    }

    log.fine("deleted asset in '${asset.file.path}'");

    return const Right(null);
  }

  /// Possible failures:
  /// * [DownloadFailed]
  @override
  Future<Either<Failure, AssetInfo>> downloadAsset(String url) async {
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

    return Right(AssetInfo(response.data, mimetype, hash));
  }

  /// Possible failures:
  /// * [AssetNotFound]
  @override
  Future<Either<Failure, AssetData>> getAsset(int assetId) async {
    final query = database.select(database.assets)
      ..where((tbl) => tbl.id.equals(assetId));

    try {
      final asset = await query.getSingle();
      return Right(AssetData.fromModel(asset));
    } catch (e) {
      return const Left(AssetNotFound());
    }
  }

  Future<void> _update(AssetsCompanion companion) async {
    final statement = database.update(database.assets)
      ..whereSamePrimaryKey(companion);

    await statement.write(companion);
  }
}
