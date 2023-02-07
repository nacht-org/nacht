import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';

import '../failures/failures.dart';

final readAssetAsStringProvider = Provider<ReadAssetAsString>(
  (ref) => ReadAssetAsString(),
  name: 'ReadAssetAsStringProvider',
);

class ReadAssetAsString with LoggerMixin {
  Future<Either<Failure, String>> call(AssetData asset) async {
    if (asset.file == null) {
      return Left(AssetNotFound(asset.file));
    }

    final content = await asset.file!.readAsString();
    final hash = AssetData.hashString(content);

    if (hash != asset.hash) {
      log.warning(
          "hash mismatch for '${asset.file!.path}', expected ${asset.hash} was $hash.");
      return Left(AssetHashMismatch(hash, asset.hash));
    }

    return Right(content);
  }
}
