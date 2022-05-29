import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';

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

  void setFontFamily(ReaderFontFamily fontFamily) {
    _preferences.setInt(ReaderPreferences.fontFamilyKey, fontFamily.value);
    state = state.copyWith(fontFamily: fontFamily);
  }

  void setFontSize(double value) {
    _preferences.setDouble(ReaderPreferences.fontSizeKey, value);
    state = state.copyWith(fontSize: value);
  }
}
