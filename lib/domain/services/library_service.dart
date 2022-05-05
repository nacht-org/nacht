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
    required this.categoryRepository,
    required this.novelRepository,
  });

  final CategoryRepository categoryRepository;
  final NovelRepository novelRepository;

  Future<Either<Failure, bool>> changeCategory(
    NovelData novel,
    Map<CategoryData, bool> categories,
  ) async {
    await categoryRepository.changeNovelCategories(novel, categories);

    final favourite = categories.values.firstWhere(
      (selected) => selected,
      orElse: () => false,
    );

    await novelRepository.setFavourite(novel.id, favourite);

    return Right(favourite);
  }

  Future<List<CategoryData>> categories({
    bool fetchNovels = false,
  }) async {
    final categories = await categoryRepository.getAllCategories();

    if (fetchNovels) {
      return categories;
    } else {
      final entities = <CategoryData>[];
      for (final category in categories) {
        final novels = await categoryRepository.getNovelsOfCategory(category);
        entities.add(category.copyWith(novels: novels));
      }

      return entities;
    }
  }
}
