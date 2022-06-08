import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkTypeSeed', () {
    const map = {
      WorkTypeSeed.original: OriginalWork(),
      WorkTypeSeed.translationHuman: TranslatedWork.human(),
      WorkTypeSeed.translationMtl: TranslatedWork.mtl(),
      WorkTypeSeed.translationUnknown: TranslatedWork.unknown(),
      WorkTypeSeed.unknown: UnknownWorkType(),
    };

    test('fromWorkType should convert sources.WorkType into seed id', () {
      for (final entry in map.entries) {
        final result = WorkTypeSeed.fromWorkType(entry.value);
        expect(result, entry.key);
      }
    });

    test('intoWorkType should convert seed id into sources.WorkType', () {
      for (final entry in map.entries) {
        final result = WorkTypeSeed.intoWorkType(entry.key);
        expect(result, entry.value);
      }
    });
  });
}
