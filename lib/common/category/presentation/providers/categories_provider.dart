import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<CategoryData>>(
  (ref) => CategoriesNotifier(
    streamCategories: ref.watch(watchCategoriesProvider),
  ),
  name: 'CategoriesProvider',
);

class CategoriesNotifier extends StateNotifier<List<CategoryData>> {
  CategoriesNotifier({
    required WatchCategories streamCategories,
  })  : _streamCategories = streamCategories,
        super([]);

  final WatchCategories _streamCategories;

  Future<void> initialize() async {
    _streamCategories.execute().listen((event) {
      state = event;
    });
  }
}
