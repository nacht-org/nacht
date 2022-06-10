import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/app_database.dart';
import 'package:nacht/features/category/domain/domain.dart';

final editCategoryProvider = Provider<EditCategory>(
  (ref) => EditCategory(
    database: ref.watch(databaseProvider),
  ),
  name: "EditCategoryProvider",
);

class EditCategory {
  EditCategory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, void>> execute(CategoryData category) async {
    final companion = NovelCategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      categoryIndex: Value(category.index),
    );

    final didUpdate =
        await _database.update(_database.novelCategories).replace(companion);

    if (didUpdate) {
      return const Right(null);
    } else {
      return const Left(CategoryEditFailed());
    }
  }
}
