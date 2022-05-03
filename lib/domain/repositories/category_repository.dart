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
  Future<List<CategoryData>> getAllCategories();

  Future<List<CategoryData>> getCategoriesOfNovel(NovelData novel);

  Future<void> changeNovelCategories(
    NovelData novel,
    Map<CategoryData, bool> categories,
  );

  Future<List<NovelData>> getNovelsOfCategory(CategoryData category);
}
