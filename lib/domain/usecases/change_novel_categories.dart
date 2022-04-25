import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

class ChangeNovelCategories {
  ChangeNovelCategories({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  Future<Either<Failure, void>> execute(
    NovelEntity novel,
    List<CategoryEntity> categories,
  ) async {
    return await categoryRepository.changeNovelCategories(novel, categories);
  }
}
