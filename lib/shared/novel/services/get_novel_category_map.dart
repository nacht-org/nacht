import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';

final getNovelCategoryMapProvider = Provider<GetNovelCategoryMap>(
  (ref) => GetNovelCategoryMap(
    ref: ref,
    getNovelCategories: ref.watch(getNovelCategoriesProvider),
  ),
  name: 'GetNovelCategoryMapProvider',
);

class GetNovelCategoryMap {
  GetNovelCategoryMap({
    required Ref ref,
    required GetNovelCategories getNovelCategories,
  })  : _ref = ref,
        _getNovelCategories = getNovelCategories;

  final Ref _ref;
  final GetNovelCategories _getNovelCategories;

  Future<Map<CategoryData, bool>> execute(int novelId) async {
    final selected = await _getNovelCategories.execute(novelId);
    final selectedIds = selected.map((category) => category.id).toSet();

    final categories = _ref.read(categoriesProvider);
    return {
      for (final category in categories)
        category: selectedIds.contains(category.id)
    };
  }
}
