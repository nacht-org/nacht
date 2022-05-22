import 'package:chapturn/components/reader/model/toolbar_info.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final toolbarProvider = StateNotifierProvider<ToolbarNotifier, ToolbarInfo>(
  (ref) => ToolbarNotifier(
    state: ToolbarInfo(visible: true),
  ),
  name: 'ToolbarProvider',
);

class ToolbarNotifier extends StateNotifier<ToolbarInfo> {
  ToolbarNotifier({
    required ToolbarInfo state,
  }) : super(state);

  void toggle() {
    state = state.copyWith(visible: !state.visible);
    _updateSystemUiMode();
  }

  void hide() {
    state = state.copyWith(visible: false);
    _updateSystemUiMode();
  }

  void show() {
    state = state.copyWith(visible: true);
    _updateSystemUiMode();
  }

  void _updateSystemUiMode() {
    if (state.visible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.top,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
  }
}
