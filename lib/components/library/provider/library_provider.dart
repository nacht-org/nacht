import 'package:chapturn/domain/entities/category/category_data.dart';
import 'package:chapturn/domain/services/library_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final libraryProvider =
    StateNotifierProvider<LibraryNotifier, List<CategoryData>>(
  (ref) => LibraryNotifier(
    libraryService: ref.watch(libraryServiceProvider),
  ),
  name: 'LibraryProvider',
);

class LibraryNotifier extends StateNotifier<List<CategoryData>> {
  LibraryNotifier({
    required LibraryService libraryService,
  })  : _libraryService = libraryService,
        super([]);

  final LibraryService _libraryService;

  Future<void> reload() async {
    state = await _libraryService.categories(fetchNovels: true);
  }
}
