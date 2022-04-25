import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategoriesOfNovel(
      NovelEntity novel);

  Future<Either<Failure, void>> changeNovelCategories(
    NovelEntity novel,
    List<CategoryEntity> categories,
  );
}
