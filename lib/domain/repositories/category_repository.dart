import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategories();

  Future<Either<Failure, List<CategoryEntity>>> getCategoriesOfNovel(
      NovelEntity novel);

  Future<void> changeNovelCategories(
    NovelEntity novel,
    List<CategoryEntity> categories,
  );
}
