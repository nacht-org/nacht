import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

typedef CategorySelection = Map<CategoryData, bool>;

final selectedCategoriesProvider = StateNotifierProvider.autoDispose
    .family<SelectedCategoriesNotifier, CategorySelection, CategorySelection>(
  (ref, map) => SelectedCategoriesNotifier(map),
  name: 'SelectedCategoriesProvider',
);

class SelectedCategoriesNotifier extends StateNotifier<CategorySelection> {
  SelectedCategoriesNotifier(super.state);

  void setSelected(int id, bool value) {
    state = {
      for (final entry in state.entries)
        if (entry.key.id == id) entry.key: value else entry.key: entry.value
    };
  }
}
