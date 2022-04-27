import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/usecases/category/get_all_categories_with_novels.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LibraryController extends StateNotifier<List<NovelCategoryEntity>> {
  LibraryController({
    required this.getAllCategoriesWithNovels,
  }) : super([]);

  final GetAllCategoriesWithNovels getAllCategoriesWithNovels;

  Future<void> reload() async {
    state = await getAllCategoriesWithNovels.execute();
  }
}
