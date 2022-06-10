import 'package:flutter/material.dart';
import 'package:nacht/nht/core/preferences/preference_key.dart';

enum ThemeModePreference implements EnumPreference {
  system(0, 'System', mode: ThemeMode.system),
  light(1, 'Light', mode: ThemeMode.light),
  dark(2, 'Dark', mode: ThemeMode.dark);

  const ThemeModePreference(this.id, this.name, {required this.mode});

  @override
  final int id;
  final String name;
  final ThemeMode mode;

  factory ThemeModePreference.parse(int id) {
    switch (id) {
      case 0:
        return ThemeModePreference.system;
      case 1:
        return ThemeModePreference.light;
      case 2:
        return ThemeModePreference.dark;
    }

    throw Exception("error parsing theme.theme-mode");
  }
}
