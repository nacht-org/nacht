import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';

final verticalReaderPreferencesProvider = StateNotifierProvider<
    VerticalReaderPreferencesNotifier, VerticalReaderPreferences>(
  (ref) => VerticalReaderPreferencesNotifier(
    preferences: ref.watch(
      preferencesProvider('reader.vertical'),
    ),
  ),
  name: 'VerticalReaderPreferencesProvider',
);

class VerticalReaderPreferencesNotifier
    extends StateNotifier<VerticalReaderPreferences> {
  VerticalReaderPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(VerticalReaderPreferences.read(preferences));

  final Preferences _preferences;

  void setShowScrollbar(bool value) {
    VerticalReaderPreferences.showScrollbarKey.setValue(_preferences, value);
    state = state.copyWith(showScrollbar: value);
  }
}
