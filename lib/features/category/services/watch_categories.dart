import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

import '../models/models.dart';

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
    final query = _database.customSelect(
      "SELECT *, "
      "(SELECT COUNT(*) FROM novel_categories_junction nc WHERE nc.category_id = c.id) AS 'amount' "
      "FROM novel_categories c;",
      readsFrom: {_database.novelCategoriesJunction, _database.novelCategories},
    );

    final stream = query.watch();
    return stream.map(
      (event) => event.map((row) {
        final category = _database.novelCategories.map(row.data);
        final novelCount = row.read<int>('amount');

        return CategoryData.fromModel(category, novelCount: novelCount);
      }).toList(),
    );
  }
}
