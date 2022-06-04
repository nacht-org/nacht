import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/database/database.dart';

final watchCategoriesProvider = Provider<WatchCategories>(
  (ref) => WatchCategories(
    database: ref.watch(databaseProvider),
  ),
  name: 'StreamCategoriesProvider',
);

class WatchCategories {
  WatchCategories({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<List<CategoryData>> execute() {
    final novelCount = _database.novelCategoriesJunction.novelId.count();

    final query = _database.select(_database.novelCategories).join([
      leftOuterJoin(
        _database.novelCategoriesJunction,
        _database.novelCategoriesJunction.categoryId
            .equalsExp(_database.novelCategories.id),
        useColumns: false,
      ),
    ])
      ..addColumns([novelCount]);

    final stream = query.watch();
    return stream.map(
      (rows) => rows.map((row) {
        final category = row.readTable(_database.novelCategories);
        final count = row.read(novelCount);

        return CategoryData.fromModel(category).copyWith(novelCount: count);
      }).toList(),
    );
  }
}
