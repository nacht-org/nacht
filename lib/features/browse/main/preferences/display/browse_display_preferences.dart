import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import 'browse_display_mode.dart';

part 'browse_display_preferences.freezed.dart';

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
