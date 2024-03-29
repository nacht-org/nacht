import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

final toolbarProvider =
    StateNotifierProvider.autoDispose<ToolbarNotifier, ToolbarInfo>(
  (ref) => ToolbarNotifier(
    state: ToolbarInfo(
      visible: false,
    ),
  ),
  name: 'ToolbarProvider',
);

class ToolbarNotifier extends StateNotifier<ToolbarInfo> {
  ToolbarNotifier({
    required ToolbarInfo state,
  }) : super(state);

  void toggle() {
    state = state.copyWith(visible: !state.visible);
    setSystemUiMode(state.visible);
  }

  void hide() {
    if (!state.visible) return;

    state = state.copyWith(visible: false);
    setSystemUiMode(state.visible);
  }

  void show() {
    state = state.copyWith(visible: true);
    setSystemUiMode(state.visible);
  }

  void setSystemUiMode(bool visible) {}
}
