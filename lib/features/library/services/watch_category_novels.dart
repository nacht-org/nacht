import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/database/database.dart';

final watchCategoryNovelsProvider = Provider<WatchCategoryNovels>(
  (ref) => WatchCategoryNovels(
    database: ref.watch(databaseProvider),
  ),
  name: 'StreamCategoryNovelsProvider',
);

class WatchCategoryNovels {
  WatchCategoryNovels({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<List<NovelData>> execute(int categoryId) {
    final query = _database.select(_database.novels).join([
      leftOuterJoin(
        _database.novelCategoriesJunction,
        _database.novelCategoriesJunction.novelId
            .equalsExp(_database.novels.id),
        useColumns: false,
      ),
    ])
      ..where(_database.novelCategoriesJunction.categoryId.equals(categoryId));

    final stream = query.watch();
    return stream.map(
      (event) => event.map((row) {
        final novel = row.readTable(_database.novels);
        return NovelData.fromModel(novel);
      }).toList(),
    );
  }
}
