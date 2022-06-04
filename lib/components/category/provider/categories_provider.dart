import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'dart:math' as math;

import 'package:nacht/core/core.dart';
import 'package:nacht/domain/domain.dart';

final categoriesProvider =
    StateNotifierProvider.autoDispose<CategoriesNotifier, List<CategoryData>?>(
  (ref) => CategoriesNotifier(
    state: null,
    read: ref.read,
    libraryService: ref.watch(libraryServiceProvider),
    messageService: ref.watch(messageServiceProvider),
  ),
  name: 'CategoriesProvider',
);

class CategoriesNotifier extends StateNotifier<List<CategoryData>?>
    with LoggerMixin {
  CategoriesNotifier({
    required List<CategoryData>? state,
    required Reader read,
    required LibraryService libraryService,
    required MessageService messageService,
  })  : _read = read,
        _libraryService = libraryService,
        _messageService = messageService,
        super(state);

  final Reader _read;
  final LibraryService _libraryService;
  final MessageService _messageService;

  Future<void> reload() async {
    final categories = await _libraryService.categories();
    final data = categories.where((element) => !element.isDefault).toList();
    state = _sort(data);
  }

  Future<void> add(String name) async {
    if (name.isEmpty) {
      _messageService.showText('Category name cannot be empty.');
      return;
    }

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

  Future<void> edit(CategoryData category, String name) async {
    if (name.isEmpty) {
      _messageService.showText('Category name cannot be empty.');
      return;
    } else if (category.name == name) {
      return;
    }

    final newCategory = category.copyWith(name: name);

    final result = await _libraryService.editCategory(newCategory);

    result.fold((failure) {
      log.warning(failure);
    }, (data) {
      assert(state != null);

      state = [
        ...state!.sublist(0, newCategory.index - 1),
        newCategory,
        ...state!.sublist(newCategory.index),
      ];
    });
  }

  Future<void> remove(Set<int> ids) async {
    assert(state != null);

    final oldState = state;
    state = [
      for (final category in state!)
        if (!ids.contains(category.id)) category
    ];

    _messageService.showUndo(
      '${ids.length} categories removed',
      onUndo: () {
        log.fine('undid ${ids.length} category removes');
        state = oldState;
      },
      orElse: () async {
        log.fine('commited ${ids.length} category removes');
        final result = await _libraryService.removeCategories(ids);

        result.fold(
          (failure) {
            log.warning(failure);
            state = oldState;
          },
          (data) => {},
        );
      },
    );
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    assert(state != null);
    assert(oldIndex != newIndex);

    final category = state![oldIndex];

    final newState = [
      ...state!.sublist(0, oldIndex),
      ...state!.sublist(oldIndex + 1, state!.length),
    ];

    if (oldIndex > newIndex) {
      newState.insert(newIndex, category);
    } else {
      newState.insert(newIndex - 1, category);
    }

    final oldState = state;
    state = newState;

    final changed = <CategoryData>[];
    for (var i = 0; i < newState.length; i++) {
      final category = newState[i];
      if (category.index != i + 1) {
        newState[i] = category.copyWith(index: i + 1);
        changed.add(newState[i]);
      }
    }

    final result = await _libraryService.updateCategoriesOrder(changed);
    result.fold(
      (failure) {
        log.warning(failure);
        state = oldState;
      },
      (_) {},
    );
  }

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
