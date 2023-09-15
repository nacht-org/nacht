import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

part 'novel_grid_preferences.freezed.dart';

@freezed
class NovelGridPreferences with _$NovelGridPreferences {
  const factory NovelGridPreferences({
    required int? gridSize,
  }) = _NovelGridPreferences;

  static const gridSizeKey = GridSizeKey('grid-size');

  factory NovelGridPreferences.read(Preferences preferences) {
    return NovelGridPreferences(
      gridSize: gridSizeKey.getValue(preferences, 0),
    );
  }

  const NovelGridPreferences._();
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
