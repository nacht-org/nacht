import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

final getNovelCategoryMapProvider = Provider<GetNovelCategoryMap>(
  (ref) => GetNovelCategoryMap(
    read: ref.read,
    getNovelCategories: ref.watch(getNovelCategoriesProvider),
  ),
  name: 'GetNovelCategoryMapProvider',
);

class GetNovelCategoryMap {
  GetNovelCategoryMap({
    required Reader read,
    required GetNovelCategories getNovelCategories,
  })  : _read = read,
        _getNovelCategories = getNovelCategories;

  final Reader _read;
  final GetNovelCategories _getNovelCategories;

  Future<Map<CategoryData, bool>> execute(int novelId) async {
    final selected = await _getNovelCategories.execute(novelId);
    final selectedIds = selected.map((category) => category.id).toSet();

    final categories = _read(categoriesProvider);
    return {
      for (final category in categories)
        category: selectedIds.contains(category.id)
    };
  }
}
