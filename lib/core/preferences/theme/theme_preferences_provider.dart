import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';

final themePreferencesProvider =
    StateNotifierProvider<ThemePreferencesNotifier, ThemePreferences>(
  (ref) => ThemePreferencesNotifier(
    preferences: ref.watch(preferencesProvider('theme')),
  ),
  name: 'ThemePreferencesProvider',
);

class ThemePreferencesNotifier extends StateNotifier<ThemePreferences> {
  ThemePreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(ThemePreferences.read(preferences));

  final Preferences _preferences;

  void setThemeMode(ThemeModePreference value) {
    ThemePreferences.themeModeKey.setValue(_preferences, value);
    state = state.copyWith(themeMode: value);
  }
}
