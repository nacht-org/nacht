import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/core/preferences/date_format/models/relative_timestamp.dart';

void main() {
  group("RelativeTimestamp", () {
    final map = {
      0: RelativeTimestamp.disabled,
      1: RelativeTimestamp.short,
      2: RelativeTimestamp.long,
    };

    test("should parse relative timestamp form id", () {
      for (final entry in map.entries) {
        expect(RelativeTimestamp.parse(entry.key), entry.value);
      }
    });
  });
}
