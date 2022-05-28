import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/core/preferences/reader/model/reader_font_family.dart';
import 'package:nacht/extrinsic/core/preferences/preferences.dart';

part 'reader_preferences.freezed.dart';

@freezed
class ReaderPreferences with _$ReaderPreferences {
  factory ReaderPreferences({
    required ReaderFontFamily fontFamily,
  }) = _ReaderPreferences;

  static const String fontFamilyKey = "font-family";

  factory ReaderPreferences.read(Preferences preferences) {
    return ReaderPreferences(
      fontFamily: parseReaderFontFamily(preferences.getInt(fontFamilyKey, 0)),
    );
  }

  ReaderPreferences._();
}
