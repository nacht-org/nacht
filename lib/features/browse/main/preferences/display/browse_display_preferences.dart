import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/browse/main/preferences/preferences.dart';
import 'package:nacht/nht/nht.dart';

part 'browse_display_preferences.freezed.dart';

final browseDisplayPreferencesProvider = StateNotifierProvider<
    BrowseDisplayPreferencesNotifier, BrowseDisplayPreferences>(
  (ref) => BrowseDisplayPreferencesNotifier(
      preferences: ref.watch(preferencesProvider('browse.display'))),
);

@freezed
class BrowseDisplayPreferences with _$BrowseDisplayPreferences {
  const factory BrowseDisplayPreferences({
    required BrowseDisplayMode displayMode,
  }) = _BrowseDisplayPreferences;

  static const displayModeKey =
      EnumPreferenceKey('display-mode', parse: BrowseDisplayMode.parse);

  factory BrowseDisplayPreferences.read(Preferences preferences) {
    return BrowseDisplayPreferences(
      displayMode:
          displayModeKey.getValue(preferences, BrowseDisplayMode.compactGrid),
    );
  }

  const BrowseDisplayPreferences._();
}
