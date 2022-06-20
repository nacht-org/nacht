import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

part 'general_reader_preferences.freezed.dart';

@freezed
class GeneralReaderPreferences with _$GeneralReaderPreferences {
  factory GeneralReaderPreferences({
    required bool showScrollbar,
  }) = _GeneralReaderPreferences;

  static const showScrollbarKey = BoolPreferenceKey('show-scrollbar');

  factory GeneralReaderPreferences.read(Preferences preferences) {
    return GeneralReaderPreferences(
      showScrollbar: showScrollbarKey.getValue(preferences, false),
    );
  }

  GeneralReaderPreferences._();
}
