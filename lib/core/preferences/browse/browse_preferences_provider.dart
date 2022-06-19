import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';

final browsePreferencesProvider =
    StateNotifierProvider<BrowsePreferencesNotifier, BrowsePreferences>(
  (ref) => BrowsePreferencesNotifier(
    preferences: ref.watch(preferencesProvider('source-browse')),
  ),
  name: 'BrowsePreferencesProvider',
);

class BrowsePreferencesNotifier extends StateNotifier<BrowsePreferences> {
  BrowsePreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(BrowsePreferences.read(preferences));

  final Preferences _preferences;

  void toggleFilter(BrowseFilter bit) {
    final value = bit.toggle(state.filter);
    BrowsePreferences.filterKey.setValue(_preferences, value);
    state = state.copyWith(filter: value);
  }
}
