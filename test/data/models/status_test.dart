import 'package:nacht/data/models/status.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatusSeed', () {
    final map = {
      StatusSeed.completed: NovelStatus.completed,
      StatusSeed.hiatus: NovelStatus.hiatus,
      StatusSeed.ongoing: NovelStatus.ongoing,
      StatusSeed.unknown: NovelStatus.unknown,
    };

    test('fromStatus should convert sources.NovelStatus into seed id', () {
      for (final entry in map.entries) {
        final result = StatusSeed.fromStatus(entry.value);
        expect(result, entry.key);
      }
    });
    test('intoStatus should convert seed id into sources.NovelStatus', () {
      for (final entry in map.entries) {
        final result = StatusSeed.intoStatus(entry.key);
        expect(result, entry.value);
      }
    });
  });
}
