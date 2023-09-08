import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';
import '../services/services.dart';

/// This is always available through the whole app lifecycle
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
