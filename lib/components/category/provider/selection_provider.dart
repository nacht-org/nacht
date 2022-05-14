import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'selection_provider.freezed.dart';

final selectionProvider =
    StateNotifierProvider<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(SelectionInfo(active: false, selected: [])),
);

@freezed
class SelectionInfo with _$SelectionInfo {
  factory SelectionInfo({
    required bool active,
    required List<int> selected,
  }) = _SelectionInfo;

  bool contains(int value) => selected.contains(value);

  SelectionInfo._();
}

class SelectionNotifier extends StateNotifier<SelectionInfo> {
  SelectionNotifier(super.state);

  void toggle(int id) {
    if (state.selected.contains(id)) {
      _remove(id);
    } else {
      _add(id);
    }
  }

  void _add(int id) {
    state = state.copyWith(
      active: true,
      selected: [...state.selected, id],
    );
  }

  void _remove(int toRemove) {
    final selected = [
      for (final id in state.selected)
        if (id != toRemove) id
    ];

    state = state.copyWith(
      selected: selected,
    );
  }

  void deactivate() {
    state = state.copyWith(
      active: false,
      selected: [],
    );
  }
}
