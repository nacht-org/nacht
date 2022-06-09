import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<CategoryData>>(
  (ref) => CategoriesNotifier(
    watchCategories: ref.watch(watchCategoriesProvider),
  ),
  name: 'CategoriesProvider',
);

class CategoriesNotifier extends StateNotifier<List<CategoryData>> {
  CategoriesNotifier({
    required WatchCategories watchCategories,
  })  : _watchCategories = watchCategories,
        super([
          CategoryData(
            id: 1,
            index: 0,
            name: "Default",
            isDefault: true,
            novelCount: 0,
          ),
        ]);

  final WatchCategories _watchCategories;

  Future<void> initialize() async {
    _watchCategories.execute().listen((event) async {
      state = event;
    });
  }
}
