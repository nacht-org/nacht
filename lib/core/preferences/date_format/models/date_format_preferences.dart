import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import '../date_format.dart';

part 'date_format_preferences.freezed.dart';

@freezed
class DateFormatPreferences with _$DateFormatPreferences {
  factory DateFormatPreferences({
    required DateFormatPattern pattern,
    required RelativeTimestamp relative,
  }) = _DateFormatPreferences;

  static const patternKey =
      EnumPreferenceKey("date-format-pattern", parse: DateFormatPattern.parse);
  static const relativeKey =
      EnumPreferenceKey("relative-timestamp", parse: RelativeTimestamp.parse);

  factory DateFormatPreferences.read(Preferences preferences) {
    return DateFormatPreferences(
      pattern: patternKey.getValue(preferences, DateFormatPattern.basic),
      relative: relativeKey.getValue(preferences, RelativeTimestamp.long),
    );
  }

  DateFormatPreferences._();
}
