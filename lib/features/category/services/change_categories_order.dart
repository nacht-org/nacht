import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

import '../models/models.dart';

final updateCategoriesIndexProvider = Provider<UpdateCategoriesIndex>(
  (ref) => UpdateCategoriesIndex(
    database: ref.watch(databaseProvider),
  ),
  name: 'UpdateCategoriesIndexProvider',
);

class UpdateCategoriesIndex {
  UpdateCategoriesIndex({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Failure?> execute(List<CategoryData> categories) async {
    await _database.transaction(() async {
      for (final category in categories) {
        final companion = NovelCategoriesCompanion(
          id: Value(category.id),
          categoryIndex: Value(category.index),
        );

        await (_database.update(_database.novelCategories)
              ..whereSamePrimaryKey(companion))
            .write(companion);
      }
    });

    return null;
  }
}
