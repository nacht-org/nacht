import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/features/features.dart';

final getAssetProvider = Provider<GetAsset>(
  (ref) => GetAsset(
    database: ref.watch(databaseProvider),
  ),
  name: 'GetAssetProvider',
);

class GetAsset {
  const GetAsset({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<AssetData?> call(int assetId) async {
    final query = _database.select(_database.assets)
      ..where((tbl) => tbl.id.equals(assetId));

    final model = await query.getSingleOrNull();
    if (model == null) {
      return null;
    }

    return AssetData.fromModel(model);
  }
}
