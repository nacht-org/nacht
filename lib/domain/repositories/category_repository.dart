import '../entities/entities.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategories();

  Future<List<CategoryEntity>> getCategoriesOfNovel(NovelEntity novel);

  Future<void> changeNovelCategories(
    NovelEntity novel,
    Map<CategoryEntity, bool> categories,
  );

  Future<List<NovelEntity>> getNovelsOfCategory(CategoryEntity category);
}
