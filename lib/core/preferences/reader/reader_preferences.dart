import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/extrinsic/extrinsic.dart';

import 'reader.dart';

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

  Future<void> setFontFamily(ReaderFontFamily fontFamily) async {
    _preferences.setInt(ReaderPreferences.fontFamilyKey, fontFamily.value);
    state = state.copyWith(fontFamily: fontFamily);
  }
}
