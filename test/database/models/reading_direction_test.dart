import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReadingDirectionSeed', () {
    final map = {
      ReadingDirectionSeed.ltr: sources.ReadingDirection.ltr,
      ReadingDirectionSeed.rtl: sources.ReadingDirection.rtl,
    };

    test(
      'fromReadingDirection should convert sources.ReadingDirection into seed id',
      () {
        for (final entry in map.entries) {
          final result = ReadingDirectionSeed.fromReadingDirection(entry.value);
          expect(result, entry.key);
        }
      },
    );
    test(
      'intoReadingDirection should convert seed id into sources.ReadingDirection',
      () {
        for (final entry in map.entries) {
          final result = ReadingDirectionSeed.intoReadingDirection(entry.key);
          expect(result, entry.value);
        }
      },
    );
  });
}
