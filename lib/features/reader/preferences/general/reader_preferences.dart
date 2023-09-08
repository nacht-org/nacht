import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import '../preferences.dart';

part 'reader_preferences.freezed.dart';

@freezed
class ReaderPreferences with _$ReaderPreferences {
  factory ReaderPreferences({
    required ReaderColorMode colorMode,
    required ReaderFontFamily fontFamily,
    required double fontSize,
    required double lineHeight,
  }) = _ReaderPreferences;

  static const colorModeKey =
      EnumPreferenceKey('color-scheme', parse: ReaderColorMode.parse);
  static const fontFamilyKey =
      EnumPreferenceKey("font-family", parse: ReaderFontFamily.parse);
  static const fontSizeKey = DoublePreferenceKey('font-size');
  static const lineHeightKey = DoublePreferenceKey('line-height');

  factory ReaderPreferences.read(Preferences preferences) {
    return ReaderPreferences(
      colorMode: colorModeKey.getValue(preferences, ReaderColorMode.none),
      fontFamily: fontFamilyKey.getValue(preferences, ReaderFontFamily.basic),
      fontSize: fontSizeKey.getValue(preferences, 16.0),
      lineHeight: lineHeightKey.getValue(preferences, 1.5),
    );
  }

  ReaderPreferences._();
}
