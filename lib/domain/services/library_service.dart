import 'package:chapturn/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain.dart';

final libraryServiceProvider = Provider<LibraryService>(
  (ref) => LibraryService(
    categoryRepository: ref.watch(categoryRepositoryProvider),
    novelRepository: ref.watch(novelRepositoryProvider),
  ),
  name: 'LibraryServiceProvider',
);

class LibraryService with LoggerMixin {
  LibraryService({
    required CategoryRepository categoryRepository,
    required NovelRepository novelRepository,
  })  : _categoryRepository = categoryRepository,
        _novelRepository = novelRepository;

  final CategoryRepository _categoryRepository;
  final NovelRepository _novelRepository;

  Future<Either<Failure, CategoryData>> addCategory(int index, String name) {
    return _categoryRepository.add(index, name);
  }

  Future<Either<Failure, void>> editCategory(CategoryData category) {
    return _categoryRepository.edit(category);
  }

  Future<Either<Failure, bool>> changeCategory(
    NovelData novel,
    Map<CategoryData, bool> categories,
  ) async {
    await _categoryRepository.changeNovelCategories(novel, categories);

    final favourite = categories.values.firstWhere(
      (selected) => selected,
      orElse: () => false,
    );

    await _novelRepository.setFavourite(novel.id, favourite);

    return Right(favourite);
  }

  Future<List<CategoryData>> categories({
    bool fetchNovels = false,
  }) async {
    final categories = await _categoryRepository.getAllCategories();

    if (fetchNovels) {
      return categories;
    } else {
      final entities = <CategoryData>[];
      for (final category in categories) {
        final novels = await _categoryRepository.getNovelsOfCategory(category);
        entities.add(category.copyWith(novels: novels));
      }

      return entities;
    }
  }
}
