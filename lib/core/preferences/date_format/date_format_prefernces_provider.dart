import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';

import 'date_format.dart';

final dateFormatPreferencesProvider =
    StateNotifierProvider<DateFormatPreferencesNotifier, DateFormatPreferences>(
  (ref) => DateFormatPreferencesNotifier(
    preferences: ref.watch(preferencesProvider('date-format')),
  ),
  name: 'DateFormatPreferencesProvider',
);

class DateFormatPreferencesNotifier
    extends StateNotifier<DateFormatPreferences> {
  DateFormatPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(DateFormatPreferences.read(preferences));

  final Preferences _preferences;

  void setPattern(DateFormatPattern value) {
    DateFormatPreferences.patternKey.setValue(_preferences, value);
    state = state.copyWith(pattern: value);
  }

  void setRelative(RelativeTimestamp value) {
    DateFormatPreferences.relativeKey.setValue(_preferences, value);
    state = state.copyWith(relative: value);
  }
}
