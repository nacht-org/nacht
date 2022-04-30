import 'package:drift/drift.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/mapper.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../datasources/local/database.dart';
import '../../models/models.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.database,
    required this.categoryMapper,
    required this.novelMapper,
    required this.assetMapper,
  });

  final AppDatabase database;

  final Mapper<NovelCategory, CategoryEntity> categoryMapper;
  final Mapper<Novel, NovelEntity> novelMapper;
  final Mapper<Asset, AssetEntity> assetMapper;

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

      return novelMapper.map(novel).copyWith(
            cover: asset != null ? assetMapper.map(asset) : null,
          );
    }).toList();
  }
}
