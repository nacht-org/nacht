import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/database/database.dart';

final streamCategoriesProvider = Provider<StreamCategories>(
  (ref) => StreamCategories(
    database: ref.watch(databaseProvider),
  ),
  name: 'StreamCategoriesProvider',
);

class StreamCategories {
  StreamCategories({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<List<CategoryData>> execute() {
    final query = _database.select(_database.novelCategories);
    return query
        .watch()
        .map((categories) => categories.map(CategoryData.fromModel).toList());
  }
}
