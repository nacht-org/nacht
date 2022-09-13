import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:nacht/core/core.dart';

part 'selection_provider.freezed.dart';

@freezed
class SelectionInfo with _$SelectionInfo {
  factory SelectionInfo({
    /// Whether we are currently in selecting mode.
    required bool active,

    /// Ids of all items currently selected.
    required Set<int> selected,
  }) = _SelectionInfo;

  SelectionInfo._();

  /// Convenience factory method to create inactive selection state.
  factory SelectionInfo.initial() {
    return SelectionInfo(active: false, selected: {});
  }

  /// Convenience function to check if [value] is selected.
  bool contains(int value) => selected.contains(value);
}

class SelectionNotifier extends StateNotifier<SelectionInfo> with LoggerMixin {
  SelectionNotifier(super.state);

  /// Listen to the [SelectionNotifier] to open and close [ModalRoute] when
  /// activated and deactivated respectively.
  static void handleRoute(
    BuildContext context,
    WidgetRef ref,
    AutoDisposeStateNotifierProvider<SelectionNotifier, SelectionInfo>
        selectionProvider,
  ) {
    final log = Logger('SelectionNotifier');

    ref.listen<SelectionInfo>(selectionProvider, (previous, next) {
      if ((previous == null || previous.selected.isEmpty) &&
          next.selected.isNotEmpty) {
        log.fine('an item has been newly selected, entering selecting mode');
        ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
          onRemove: () {
            log.fine('exiting selecting mode');
            ref.read(selectionProvider.notifier).deactivate();
          },
        ));
      }

      if (previous != null &&
          previous.selected.isNotEmpty &&
          next.active &&
          next.selected.isEmpty) {
        log.fine('all items have been unselected, popping local route context');
        Navigator.of(context).pop();
      }
    });
  }

  void toggle(int id) {
    if (state.selected.contains(id)) {
      _remove(id);
    } else {
      _add(id);
    }
  }

  void addAll(Iterable<int> ids) {
    state = state.copyWith(selected: {...state.selected, ...ids});
  }

  void flipAll(Iterable<int> ids) {
    state = state.copyWith(selected: {
      for (final id in ids)
        if (!state.selected.contains(id)) id
    });
  }

  void deactivate() {
    state = state.copyWith(
      active: false,
      selected: {},
    );
  }

  void _add(int id) {
    state = state.copyWith(
      active: true,
      selected: {...state.selected, id},
    );
  }

  void _remove(int toRemove) {
    final selected = {
      for (final id in state.selected)
        if (id != toRemove) id
    };

    state = state.copyWith(
      selected: selected,
    );
  }
}
