import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

part 'browse_preferences.freezed.dart';

@freezed
class BrowsePreferences with _$BrowsePreferences {
  factory BrowsePreferences({
    required int filter,
  }) = _BrowsePreferences;

  static const filterKey = IntPreferenceKey('filter');

  static BrowsePreferences read(Preferences preferences) {
    return BrowsePreferences(
      filter: filterKey.getValue(preferences, 0),
    );
  }

  BrowsePreferences._();
}
