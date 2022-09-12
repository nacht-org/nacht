import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationInfo>(
  (ref) => NavigationNotifier(
    state: const NavigationInfo(
      event: ScrollEvent.end(),
      forceHide: false,
    ),
  ),
  name: "NavigationProvider",
);

class NavigationNotifier extends StateNotifier<NavigationInfo>
    with LoggerMixin {
  NavigationNotifier({
    required NavigationInfo state,
  }) : super(state);

  /// All currently registered scroll controller listeners
  final Map<ScrollController, List<VoidCallback>> _listeners = {};

  void _scrollDelta(ScrollInfo scroll) {
    final delta = scroll.update();
    log.info("Navigation offset changed by $delta");
    state = state.copyWith(event: ScrollEvent.delta(delta));
  }

  void _scrollEnd(ScrollInfo scroll) {
    if (!scroll.controller.position.isScrollingNotifier.value) {
      state = state.copyWith(event: const ScrollEvent.end());
    }
  }

  void attach(ScrollController controller) {
    if (_listeners.containsKey(controller)) {
      log.warning("Attempted to attach scroll controller more than once");
      return;
    }

    final scroll = ScrollInfo(controller);

    void scrollDelta() => _scrollDelta(scroll);
    void scrollEnd() => _scrollEnd(scroll);

    _listeners[controller] = [scrollDelta, scrollEnd];
    scroll.controller.addListener(scrollDelta);
    scroll.controller.position.isScrollingNotifier.addListener(scrollEnd);

    log.fine("Attached scroll controller");
  }

  void detach(ScrollController controller) {
    final callbacks = _listeners[controller];
    if (callbacks != null) {
      for (final callback in callbacks) {
        controller.removeListener(callback);
      }
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
