import 'package:chapturn/data/models/reading_direction.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReadingDirectionSeed', () {
    final map = {
      ReadingDirectionSeed.ltr: ReadingDirection.ltr,
      ReadingDirectionSeed.rtl: ReadingDirection.rtl,
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
