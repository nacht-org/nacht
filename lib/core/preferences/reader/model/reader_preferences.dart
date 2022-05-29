import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/core/preferences/reader/model/reader_font_family.dart';
import 'package:nacht/nht/nht.dart';

part 'reader_preferences.freezed.dart';

@freezed
class ReaderPreferences with _$ReaderPreferences {
  factory ReaderPreferences({
    required ReaderFontFamily fontFamily,
    required double fontSize,
  }) = _ReaderPreferences;

  static const String fontFamilyKey = "font-family";
  static const String fontSizeKey = 'font-size';

  factory ReaderPreferences.read(Preferences preferences) {
    return ReaderPreferences(
      fontFamily: parseReaderFontFamily(preferences.getInt(fontFamilyKey, 0)),
      fontSize: preferences.getDouble(fontSizeKey, 14.0),
    );
  }

  ReaderPreferences._();
}
