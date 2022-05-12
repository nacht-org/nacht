import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedProvider = StateNotifierProvider<SelectedNotifier, Set<int>>(
  (ref) => SelectedNotifier({}),
);

class SelectedNotifier extends StateNotifier<Set<int>> {
  SelectedNotifier(super.state);

  void add(int id) {
    state = {...state, id};
  }

  void remove(int toRemove) {
    state = {
      for (final id in state)
        if (id != toRemove) id
    };
  }
}
