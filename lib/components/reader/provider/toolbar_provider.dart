import 'package:nacht/components/reader/model/toolbar_info.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final toolbarProvider =
    StateNotifierProvider.autoDispose<ToolbarNotifier, ToolbarInfo>(
  (ref) => ToolbarNotifier(
    state: ToolbarInfo(visible: false),
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

  void setSystemUiMode(bool visible) {
    if (visible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.top,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
  }
}
