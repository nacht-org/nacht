import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<CategoryData>>(
  (ref) => CategoriesNotifier(
    streamCategories: ref.watch(streamCategoriesProvider),
  ),
  name: 'CategoriesProvider',
);

class CategoriesNotifier extends StateNotifier<List<CategoryData>> {
  CategoriesNotifier({
    required StreamCategories streamCategories,
  })  : _streamCategories = streamCategories,
        super([]);

  final StreamCategories _streamCategories;

  Future<void> initialize() async {
    _streamCategories.execute().listen((event) {
      state = event;
    });
  }
}
