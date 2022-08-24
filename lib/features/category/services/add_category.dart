import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

import '../failures/category_add_failed.dart';

final addCategoryProvider = Provider<AddCategory>(
  (ref) => AddCategory(
    database: ref.watch(databaseProvider),
  ),
  name: "AddCategoryProvider",
);

class AddCategory {
  AddCategory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, CategoryData>> execute(int index, String name) async {
    final companion = NovelCategoriesCompanion.insert(
      categoryIndex: index,
      name: name,
    );

    try {
      final model = await _database
          .into(_database.novelCategories)
          .insertReturning(companion);

      return Right(CategoryData.fromModel(model));
    } catch (e) {
      return const Left(CategoryAddFailed());
    }
  }
}
