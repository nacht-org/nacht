import 'package:chapturn/core/services/dialog_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import 'package:chapturn/core/core.dart';
import 'package:chapturn/domain/domain.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<CategoryData>?>(
  (ref) => CategoriesNotifier(
    state: null,
    libraryService: ref.watch(libraryServiceProvider),
    dialogService: ref.watch(dialogServiceProvider),
  ),
  name: 'CategoriesProvider',
);

class CategoriesNotifier extends StateNotifier<List<CategoryData>?>
    with LoggerMixin {
  CategoriesNotifier({
    required List<CategoryData>? state,
    required LibraryService libraryService,
    required DialogService dialogService,
  })  : _libraryService = libraryService,
        _dialogService = dialogService,
        super(state);

  final LibraryService _libraryService;
  final DialogService _dialogService;

  Future<void> reload() async {
    final categories = await _libraryService.categories();
    final data = categories.where((element) => !element.isDefault).toList();
    state = _sort(data);
  }

  Future<void> add(String name) async {
    final result = await _libraryService.addCategory(_highestIndex() + 1, name);

    result.fold(
      (failure) {
        log.warning(failure);
      },
      (data) {
        state = _sort([...?state, data]);
      },
    );
  }

  Future<void> edit(CategoryData category) async {
    final result = await _libraryService.editCategory(category);

    result.fold((failure) {
      log.warning(failure);
    }, (data) {
      reload();
    });
  }

  Future<void> remove(CategoryData category) async {}

  int _highestIndex() {
    assert(state != null);

    if (state!.isEmpty) {
      return 0;
    }

    return state!.map((e) => e.index).reduce(math.max);
  }

  List<CategoryData> _sort(List<CategoryData> data) {
    return data..sort((a, b) => a.index.compareTo(b.index));
  }
}
