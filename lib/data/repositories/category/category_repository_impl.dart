import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';

import '../../../core/failure.dart';
import '../../../domain/domain.dart';
import '../../failure.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.database,
  });

  final AppDatabase database;

  @override
  Future<Either<Failure, CategoryData>> add(int index, String name) async {
    // TODO: test add
    final companion = NovelCategoriesCompanion.insert(
      categoryIndex: index,
      name: name,
    );

    try {
      final model = await database
          .into(database.novelCategories)
          .insertReturning(companion);

      return Right(CategoryData.fromModel(model));
    } catch (e) {
      return const Left(InsertFailure());
    }
  }

  @override
  Future<Either<Failure, void>> edit(CategoryData category) async {
    // TODO: test edit
    final companion = NovelCategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      categoryIndex: Value(category.index),
    );

    final didUpdate =
        await database.update(database.novelCategories).replace(companion);

    if (didUpdate) {
      return const Right(null);
    } else {
      return const Left(UpdateFailure());
    }
  }

  @override
  Future<Either<Failure, void>> remove(Iterable<int> ids) async {
    // TODO: test remove
    await database.batch((batch) {
      for (final id in ids) {
        batch.deleteWhere<NovelCategories, void>(
          database.novelCategories,
          (tbl) => tbl.id.equals(id),
        );
      }
    });

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateIndex(
      List<CategoryData> categories) async {
    await database.transaction(() async {
      for (final category in categories) {
        final companion = NovelCategoriesCompanion(
          id: Value(category.id),
          categoryIndex: Value(category.index),
        );

        await (database.update(database.novelCategories)
              ..whereSamePrimaryKey(companion))
            .write(companion);
      }
    });

    return const Right(null);
  }

  @override
  Future<void> changeNovelCategories(
    NovelData novel,
    Map<CategoryData, bool> categories,
  ) async {
    await database.batch((batch) {
      final toDelete = categories.entries
          .where((category) => category.value == false)
          .map((category) => category.key.id);

      batch.deleteWhere(
        database.novelCategoriesJunction,
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
          database.novelCategoriesJunction,
          NovelCategoriesJunctionCompanion.insert(
            categoryId: entry.key.id,
            novelId: novel.id,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }

  @override
  Future<List<CategoryData>> getAllCategories() async {
    final results = await database.select(database.novelCategories).get();
    return results.map(CategoryData.fromModel).toList();
  }

  @override
  Future<List<CategoryData>> getCategoriesOfNovel(
    NovelData novel,
  ) async {
    final query = database.select(database.novelCategories).join([
      leftOuterJoin(
        database.novelCategoriesJunction,
        database.novelCategoriesJunction.categoryId
            .equalsExp(database.novelCategories.id),
        useColumns: false,
      ),
    ])
      ..where(database.novelCategoriesJunction.novelId.equals(novel.id));

    final results = await query.get();

    return results.map((row) {
      final category = row.readTable(database.novelCategories);
      return CategoryData.fromModel(category);
    }).toList();
  }

  @override
  Future<List<NovelData>> getNovelsOfCategory(CategoryData category) async {
    final query = database.select(database.novels).join([
      leftOuterJoin(
        database.novelCategoriesJunction,
        database.novelCategoriesJunction.novelId.equalsExp(database.novels.id),
        useColumns: false,
      ),
      leftOuterJoin(
        database.assets,
        database.assets.id.equalsExp(database.novels.coverId),
      ),
    ])
      ..where(database.novelCategoriesJunction.categoryId.equals(category.id));

    final results = await query.get();

    return results.map((row) {
      final novel = row.readTable(database.novels);
      final asset = row.readTableOrNull(database.assets);

      return NovelData.fromModel(novel).copyWith(
        cover: asset != null ? AssetData.fromModel(asset) : null,
      );
    }).toList();
  }
}
