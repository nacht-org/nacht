import 'package:chapturn/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../domain.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    database: ref.watch(databaseProvider),
  ),
  name: 'CategoryRepositoryProvider',
);

abstract class CategoryRepository {
  Future<Either<Failure, CategoryData>> add(int index, String name);

  Future<Either<Failure, void>> edit(CategoryData category);

  Future<Either<Failure, void>> updateIndex(List<CategoryData> categories);

  Future<List<CategoryData>> getAllCategories();

  Future<List<CategoryData>> getCategoriesOfNovel(NovelData novel);

  Future<void> changeNovelCategories(
    NovelData novel,
    Map<CategoryData, bool> categories,
  );

  Future<List<NovelData>> getNovelsOfCategory(CategoryData category);

  Future<Either<Failure, void>> remove(Iterable<int> ids);
}
