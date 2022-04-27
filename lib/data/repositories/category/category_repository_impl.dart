import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/models/models.dart';
import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/entities/category/category_entity.dart';
import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.database,
    required this.categoryMapper,
    required this.novelMapper,
  });

  final AppDatabase database;

  final Mapper<NovelCategory, CategoryEntity> categoryMapper;
  final Mapper<Novel, NovelEntity> novelMapper;

  @override
  Future<void> changeNovelCategories(
    NovelEntity novel,
    Map<CategoryEntity, bool> categories,
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
  Future<List<CategoryEntity>> getAllCategories() async {
    final results = await database.select(database.novelCategories).get();
    return results.map(categoryMapper.map).toList();
  }

  @override
  Future<List<CategoryEntity>> getCategoriesOfNovel(
    NovelEntity novel,
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
      return categoryMapper.map(category);
    }).toList();
  }

  @override
  Future<List<NovelEntity>> getNovelsOfCategory(CategoryEntity category) async {
    final query = database.select(database.novels).join([
      leftOuterJoin(
        database.novelCategoriesJunction,
        database.novelCategoriesJunction.novelId.equalsExp(database.novels.id),
        useColumns: false,
      )
    ])
      ..where(database.novelCategoriesJunction.categoryId.equals(category.id));

    final results = await query.get();

    return results.map((row) {
      final novel = row.readTable(database.novels);
      return novelMapper.map(novel);
    }).toList();
  }
}
