import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import 'library_display_mode.dart';

part 'library_display_preferences.freezed.dart';

@freezed
class LibraryDisplayPreferences with _$LibraryDisplayPreferences {
  const factory LibraryDisplayPreferences({
    required LibraryDisplayMode displayMode,
    required int? gridSize,
  }) = _LibraryDisplayPreferences;

  static const displayModeKey =
      EnumPreferenceKey('display-mode', parse: LibraryDisplayMode.parse);
  static const gridSizeKey = GridSizeKey('grid-size');

  factory LibraryDisplayPreferences.read(Preferences preferences) {
    return LibraryDisplayPreferences(
      displayMode:
          displayModeKey.getValue(preferences, LibraryDisplayMode.compactGrid),
      gridSize: gridSizeKey.getValue(preferences, 0),
    );
  }

  const LibraryDisplayPreferences._();
}

class GridSizeKey extends PreferenceKey<int?> {
  const GridSizeKey(super.key);

  @override
  int? getValue(Preferences preferences, int? defaultValue) {
    final value = preferences.getInt(key, defaultValue ?? 0);
    if (value == 0) return null;
    return value;
  }

  @override
  void setValue(Preferences preferences, int? value) =>
      preferences.setInt(key, value ?? 0);
}
