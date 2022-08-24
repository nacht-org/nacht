import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

void main() {
  test(
    'should convert sources.Chapter into chapter companion with all values',
    () {
      final tSource = sources.Chapter(
        index: 2,
        title: 'my chapter',
        content: '<div>content</div>',
        url: 'https://website.com/novel/123/1',
        updated: DateTime(2022, 04, 23),
      );
      final tCompanion = ChaptersCompanion(
        chapterIndex: const Value(2),
        title: const Value('my chapter'),
        url: const Value('https://website.com/novel/123/1'),
        updated: Value(DateTime(2022, 04, 23)),
      );

      final result = sourceChapterIntoCompanion(tSource);
      expect(result, tCompanion);
    },
  );

  test(
    'should convert sources.Chapter into chapter companion with missing values',
    () {
      final tSource = sources.Chapter(
        index: 2,
        title: 'my chapter',
        url: 'https://website.com/novel/123/1',
      );
      const tCompanion = ChaptersCompanion(
        chapterIndex: Value(2),
        title: Value('my chapter'),
        url: Value('https://website.com/novel/123/1'),
      );

      final result = sourceChapterIntoCompanion(tSource);
      expect(result, tCompanion);
    },
  );
}
