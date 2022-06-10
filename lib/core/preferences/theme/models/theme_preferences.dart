import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import '../theme.dart';

part 'theme_preferences.freezed.dart';

@freezed
class ThemePreferences with _$ThemePreferences {
  factory ThemePreferences({
    required ThemeModePreference themeMode,
  }) = _ThemePreferences;

  static const themeModeKey =
      EnumPreferenceKey('theme-mode', parse: ThemeModePreference.parse);

  factory ThemePreferences.read(Preferences preferences) {
    return ThemePreferences(
      themeMode: themeModeKey.getValue(preferences, ThemeModePreference.system),
    );
  }

  ThemePreferences._();
}
