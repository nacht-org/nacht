import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategories();

  Future<List<CategoryEntity>> getCategoriesOfNovel(NovelEntity novel);

  Future<void> changeNovelCategories(
    NovelEntity novel,
    Map<CategoryEntity, bool> categories,
  );

  Future<List<NovelEntity>> getNovelsOfCategory(CategoryEntity category);
}
