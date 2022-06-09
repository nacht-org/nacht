import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';
import 'package:drift/drift.dart';

final changeNovelCategoriesProvider = Provider<ChangeNovelCategories>(
  (ref) => ChangeNovelCategories(
    database: ref.watch(databaseProvider),
  ),
  name: 'ChangeNovelCategoriesProvider',
);

class ChangeNovelCategories {
  ChangeNovelCategories({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, bool>> execute(
    NovelData novel,
    Map<CategoryData, bool> categories,
  ) async {
    await _change(novel, categories);

    final favourite = categories.values.firstWhere(
      (selected) => selected,
      orElse: () => false,
    );

    final companion = NovelsCompanion(
      id: Value(novel.id),
      favourite: Value(favourite),
    );

    await (_database.update(_database.novels)..whereSamePrimaryKey(companion))
        .write(companion);

    return Right(favourite);
  }

  Future<void> _change(
    NovelData novel,
    Map<CategoryData, bool> categories,
  ) async {
    await _database.batch((batch) {
      final toDelete = categories.entries
          .where((category) => category.value == false)
          .map((category) => category.key.id);

      batch.deleteWhere(
        _database.novelCategoriesJunction,
        (tbl) {
          final table = tbl as NovelCategoriesJunction;
          return table.novelId.equals(novel.id) &
              table.categoryId.isIn(toDelete);
        },
      );

      for (final entry in categories.entries) {
        if (entry.value == false) {
          continue;
        }

        batch.insert(
          _database.novelCategoriesJunction,
          NovelCategoriesJunctionCompanion.insert(
            categoryId: entry.key.id,
            novelId: novel.id,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }
}
