import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/providers/providers.dart';
import 'package:chapturn/presentation/controllers/library/library_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final libraryProvider =
    StateNotifierProvider<LibraryController, List<NovelCategoryEntity>>(
  (ref) {
    return LibraryController(
      getAllCategoriesWithNovels: ref.watch(getAllCategoriesWithNovels),
    )..reload();
  },
);
