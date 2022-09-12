import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationInfo>(
  (ref) => NavigationNotifier(
    state: const NavigationInfo(offset: 0, forceHide: false),
  ),
  name: "NavigationProvider",
);

class NavigationNotifier extends StateNotifier<NavigationInfo>
    with LoggerMixin {
  NavigationNotifier({
    required NavigationInfo state,
  }) : super(state);

  /// All currently registered scroll controller listeners
  final Map<ScrollController, VoidCallback> _listeners = {};

  void _updateOffset(ScrollInfo scroll) {
    final delta = scroll.update();
    log.info("Navigation offset changed to ${state.offset + delta} by $delta");
    state = state.copyWith(offset: state.offset + delta);
  }

  void attach(ScrollController controller) {
    if (_listeners.containsKey(controller)) {
      log.warning("Attempted to attach scroll controller more than once");
      return;
    }

    final scroll = ScrollInfo(controller);
    void callback() => _updateOffset(scroll);
    _listeners[controller] = callback;
    scroll.controller.addListener(callback);

    log.fine("Attached scroll controller");
  }

  void detach(ScrollController controller) {
    final callback = _listeners[controller];
    if (callback != null) {
      controller.removeListener(callback);
    }

    log.fine("Detached scroll controller");
  }

  void setForceHide(bool forceHide) {
    state = state.copyWith(forceHide: forceHide);
    log.fine("Force hide navigation set to $forceHide");
  }
}

class ScrollInfo {
  final ScrollController controller;

  double position;

  ScrollInfo(this.controller) : position = controller.position.pixels;

  double update() {
    final delta = controller.position.pixels - position;
    position = controller.position.pixels;
    return delta;
  }
}
