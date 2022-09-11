import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';

final updatableNovelsProvider = Provider(
  (ref) => UpdatableNovels(
    database: ref.watch(databaseProvider),
  ),
  name: "UpdatableNovelsProvider",
);

// All novels that can be updated.
class UpdatableNovels with LoggerMixin {
  const UpdatableNovels({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<List<NovelData>> execute() async {
    final query = _database.select(_database.novelCategoriesJunction).join([
      leftOuterJoin(
        _database.novels,
        _database.novels.id
            .equalsExp(_database.novelCategoriesJunction.novelId),
      )
    ])
      ..groupBy([_database.novels.id]);

    final results = await query.get();

    return results.map((row) {
      final novel = row.readTable(_database.novels);
      return NovelData.fromModel(novel);
    }).toList();
  }
}
