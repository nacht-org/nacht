import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

part 'vertical_reader_preferences.freezed.dart';

@freezed
class VerticalReaderPreferences with _$VerticalReaderPreferences {
  factory VerticalReaderPreferences({
    required bool showScrollbar,
  }) = _VerticalReaderPreferences;

  static const showScrollbarKey = BoolPreferenceKey('show-scrollbar');

  factory VerticalReaderPreferences.read(Preferences preferences) {
    return VerticalReaderPreferences(
      showScrollbar: showScrollbarKey.getValue(preferences, false),
    );
  }

  VerticalReaderPreferences._();
}
