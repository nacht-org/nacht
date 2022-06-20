import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';

final generalReaderPreferencesProvider = StateNotifierProvider<
    GeneralReaderPreferencesNotifier, GeneralReaderPreferences>(
  (ref) => GeneralReaderPreferencesNotifier(
    preferences: ref.watch(
      preferencesProvider('reader.general'),
    ),
  ),
  name: 'GeneralReaderPreferencesProvider',
);

class GeneralReaderPreferencesNotifier
    extends StateNotifier<GeneralReaderPreferences> {
  GeneralReaderPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(GeneralReaderPreferences.read(preferences));

  final Preferences _preferences;

  void setShowScrollbar(bool value) {
    GeneralReaderPreferences.showScrollbarKey.setValue(_preferences, value);
    state = state.copyWith(showScrollbar: value);
  }
}
