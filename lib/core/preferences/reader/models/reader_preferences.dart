import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import '../reader.dart';

part 'reader_preferences.freezed.dart';

@freezed
class ReaderPreferences with _$ReaderPreferences {
  factory ReaderPreferences({
    required ReaderFontFamily fontFamily,
    required double fontSize,
  }) = _ReaderPreferences;

  static const fontFamilyKey =
      EnumPreferenceKey("font-family", parse: ReaderFontFamily.parse);
  static const fontSizeKey = DoublePreferenceKey('font-size');

  factory ReaderPreferences.read(Preferences preferences) {
    return ReaderPreferences(
      fontFamily: fontFamilyKey.getValue(preferences, ReaderFontFamily.basic),
      fontSize: fontSizeKey.getValue(preferences, 14.0),
    );
  }

  ReaderPreferences._();
}