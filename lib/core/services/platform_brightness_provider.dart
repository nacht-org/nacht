import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final platformBrightnessProvider =
    StateNotifierProvider<PlatformBrightnessNotifier, Brightness>(
  (ref) {
    final notifier = PlatformBrightnessNotifier(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );

    final observer = _PlatformBrightnessObserver(
      onBrightnessChanged: notifier.setBrightness,
    );

    WidgetsBinding.instance.addObserver(observer);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(observer));

    return notifier;
  },
  name: 'PlatformBrightnessProvider',
);

class PlatformBrightnessNotifier extends StateNotifier<Brightness> {
  PlatformBrightnessNotifier(super.state);

  void setBrightness(Brightness value) {
    state = value;
  }
}

class _PlatformBrightnessObserver with WidgetsBindingObserver {
  const _PlatformBrightnessObserver({
    required this.onBrightnessChanged,
  });

  final ValueChanged<Brightness> onBrightnessChanged;

  @override
  void didChangePlatformBrightness() {
    onBrightnessChanged(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }
}
