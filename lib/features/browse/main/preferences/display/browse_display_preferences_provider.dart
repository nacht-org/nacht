import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/browse/main/preferences/display/browse_display_mode.dart';
import 'package:nacht/nht/nht.dart';
import 'browse_display_preferences.dart';

class BrowseDisplayPreferencesNotifier
    extends StateNotifier<BrowseDisplayPreferences> {
  BrowseDisplayPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(BrowseDisplayPreferences.read(preferences));

  final Preferences _preferences;

  void setDisplayMode(BrowseDisplayMode value) {
    state = state.copyWith(displayMode: value);
    BrowseDisplayPreferences.displayModeKey.setValue(_preferences, value);
  }
}
