import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/core/preferences/theme/theme.dart';

final brightnessProvider = Provider<Brightness>(
  (ref) {
    final platformBrightness = ref.watch(platformBrightnessProvider);
    final themeMode =
        ref.watch(themePreferencesProvider.select((theme) => theme.themeMode));

    switch (themeMode.mode) {
      case ThemeMode.system:
        return platformBrightness;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
    }
  },
);
