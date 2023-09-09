import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/library/preferences/display/library_display_mode.dart';
import 'package:nacht/features/library/preferences/display/library_display_preferences.dart';
import 'package:nacht/nht/nht.dart';

final libraryDisplayPreferencesProvider = StateNotifierProvider<
    LibraryDisplayPreferencesNotifier, LibraryDisplayPreferencs>(
  (ref) => LibraryDisplayPreferencesNotifier(
    preferences: ref.watch(
      preferencesProvider("library.display"),
    ),
  ),
);

class LibraryDisplayPreferencesNotifier
    extends StateNotifier<LibraryDisplayPreferencs> {
  LibraryDisplayPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(LibraryDisplayPreferencs.read(preferences));

  final Preferences _preferences;

  void setDisplayMode(LibraryDisplayMode displayMode) async {
    state = state.copyWith(displayMode: displayMode);
    LibraryDisplayPreferencs.displayModeKey.setValue(_preferences, displayMode);
  }
}
