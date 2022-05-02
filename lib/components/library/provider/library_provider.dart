import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/providers/providers.dart';
import '../../../domain/usecases/category/get_all_categories_with_novels.dart';

final libraryProvider =
    StateNotifierProvider<LibraryController, List<NovelCategoryEntity>>(
  (ref) {
    return LibraryController(
      getAllCategoriesWithNovels: ref.watch(getAllCategoriesWithNovels),
    );
  },
);

class LibraryController extends StateNotifier<List<NovelCategoryEntity>> {
  LibraryController({
    required this.getAllCategoriesWithNovels,
  }) : super([]);

  final GetAllCategoriesWithNovels getAllCategoriesWithNovels;

  Future<void> reload() async {
    state = await getAllCategoriesWithNovels.execute();
  }
}
