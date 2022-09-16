import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/core/preferences/theme/theme.dart';

void main() {
  group("ThemeModePreference", () {
    final map = {
      0: ThemeModePreference.system,
      1: ThemeModePreference.light,
      2: ThemeModePreference.dark,
    };

    test("should parse theme mode preference from id", () {
      for (final entry in map.entries) {
        expect(ThemeModePreference.parse(entry.key), entry.value);
      }
    });
  });
}
