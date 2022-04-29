import 'dart:io';

import 'package:chapturn/data/failure.dart';
import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/repositories/asset_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AssetRepositoryImpl implements AssetRepository {
  AssetRepositoryImpl({
    required this.database,
    required this.mimeTypeToSeedMapper,
  });

  final AppDatabase database;
  final Mapper<String, int> mimeTypeToSeedMapper;

  /// Possible failures:
  /// * [UnknownAssetType]
  @override
  Future<Either<Failure, AssetEntity>> addAsset(
    String directory,
    AssetData data, [
    String? url,
  ]) async {
    int assetType;
    try {
      assetType = mimeTypeToSeedMapper.map(data.mimetype);
    } catch (e) {
      return const Left(UnknownAssetType());
    }

    final insert = AssetsCompanion.insert(
      url: Value(url),
      hash: data.hash,
      typeId: assetType,
    );

    final assetId = await database.into(database.assets).insert(insert);
    final documentDirectory = await getApplicationDocumentsDirectory();

    final assetName = '$assetId.${data.mimetype.split("/").last}';
    final assetPath = path.join(documentDirectory.path, directory, assetName);
    final companion =
        AssetsCompanion(id: Value(assetId), path: Value(assetPath));

    try {
      File assetFile = File(assetPath);
      await assetFile.writeAsBytes(data.bytes);

      await _update(companion);
    } catch (e) {
      await (database.delete(database.assets)..whereSamePrimaryKey(companion))
          .go();
      return const Left(FileSaveError());
    }

    return Right(AssetEntity(
      id: assetId,
      url: url,
      path: assetPath,
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
}
