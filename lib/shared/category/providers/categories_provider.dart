import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

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
        super([]);

  final WatchCategories _watchCategories;

  Future<void> initialize() async {
    final stream = _watchCategories.execute();
    state = await stream.firstWhere((element) => element.isNotEmpty);

    stream.listen((data) async {
      state = data;
    });
  }
}
