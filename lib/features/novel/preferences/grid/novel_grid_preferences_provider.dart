import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/novel/preferences/grid/novel_grid_preferences.dart';
import 'package:nacht/nht/nht.dart';

final novelGridPreferencesProvider =
    StateNotifierProvider<NovelGridPreferencesNotifier, NovelGridPreferences>(
  (ref) => NovelGridPreferencesNotifier(
    preferences: ref.read(preferencesProvider('novel.grid')),
  ),
);

class NovelGridPreferencesNotifier extends StateNotifier<NovelGridPreferences> {
  NovelGridPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(NovelGridPreferences.read(preferences));

  final Preferences _preferences;

  void setGridSize(int? value) {
    state = state.copyWith(gridSize: value);
    NovelGridPreferences.gridSizeKey.setValue(_preferences, value);
  }
}
