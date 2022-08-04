import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/database/database.dart';

final getNovelCategoriesProvider = Provider<GetNovelCategories>(
  (ref) => GetNovelCategories(
    database: ref.watch(databaseProvider),
  ),
  name: 'GetNovelCategoriesProvider',
);

class GetNovelCategories {
  GetNovelCategories({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<List<CategoryData>> execute(int novelId) async {
    final query = _database.select(_database.novelCategories).join([
      leftOuterJoin(
        _database.novelCategoriesJunction,
        _database.novelCategoriesJunction.categoryId
            .equalsExp(_database.novelCategories.id),
        useColumns: false,
      ),
    ])
      ..where(_database.novelCategoriesJunction.novelId.equals(novelId));

    final results = await query.get();

    return results.map((row) {
      final category = row.readTable(_database.novelCategories);
      return CategoryData.fromModel(category);
    }).toList();
  }
}
