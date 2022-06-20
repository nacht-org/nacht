import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';

import 'reader_color_mode.dart';

final readerPreferencesProvider =
    StateNotifierProvider<ReaderPreferencesNotifier, ReaderPreferences>(
  (ref) => ReaderPreferencesNotifier(
    preferences: ref.watch(preferencesProvider("reader")),
  ),
  name: "ReaderPreferencesProvider",
);

class ReaderPreferencesNotifier extends StateNotifier<ReaderPreferences> {
  ReaderPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(ReaderPreferences.read(preferences));

  final Preferences _preferences;

  void setColorMode(ReaderColorMode colorMode) {
    ReaderPreferences.colorModeKey.setValue(_preferences, colorMode);
    state = state.copyWith(colorMode: colorMode);
  }

  void setFontFamily(ReaderFontFamily fontFamily) {
    ReaderPreferences.fontFamilyKey.setValue(_preferences, fontFamily);
    state = state.copyWith(fontFamily: fontFamily);
  }

  void setFontSize(double value) {
    ReaderPreferences.fontSizeKey.setValue(_preferences, value);
    state = state.copyWith(fontSize: value);
  }

  void setLineHeight(double value) {
    value = (value * 10).round() / 10;
    ReaderPreferences.lineHeightKey.setValue(_preferences, value);
    state = state.copyWith(lineHeight: value);
  }
}
