import 'package:nacht/data/data.dart';
import 'package:nacht/data/misc/into_companion.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chapturn_sources/chapturn_sources.dart' as sources;

void main() {
  group('chapterIntoCompanion', () {
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
          content: const Value('<div>content</div>'),
          url: const Value('https://website.com/novel/123/1'),
          updated: Value(DateTime(2022, 04, 23)),
        );

        final result = chapterIntoCompanion(tSource);
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

        final result = chapterIntoCompanion(tSource);
        expect(result, tCompanion);
      },
    );
  });

  group('metaDataIntoCompanion', () {
    test('should convert sources.MetaData into MetaDatasCompanion', () {
      final tSource = sources.MetaData('subject', 'tvalue', {});

      const tCompanion = MetaEntriesCompanion(
        name: Value('subject'),
        value: Value('tvalue'),
        namespaceId: Value(NamespaceSeed.dc),
        others: Value(null),
      );

      final result = metaDataIntoCompanion(tSource);
      expect(result, tCompanion);
    });
  });

  group('novelIntoCompanion', () {
    test('should convert sources.Novel into NovelsCompanion', () {
      final tSource = sources.Novel(
        title: 'my novel',
        description: ['in', 'many', 'words'],
        author: 'my name',
        url: 'https://website.com/novel/123',
        thumbnailUrl: 'https://website.com/novel/123/cover.jpg',
        lang: 'en',
        status: sources.NovelStatus.ongoing,
        workType: const sources.OriginalWork(),
        readingDirection: sources.ReadingDirection.ltr,
      );

      const tCompanion = NovelsCompanion(
        title: Value('my novel'),
        description: Value('in\nmany\nwords'),
        author: Value('my name'),
        url: Value('https://website.com/novel/123'),
        coverUrl: Value('https://website.com/novel/123/cover.jpg'),
        lang: Value('en'),
        statusId: Value(StatusSeed.ongoing),
        workTypeId: Value(WorkTypeSeed.original),
        readingDirectionId: Value(ReadingDirectionSeed.ltr),
      );

      final result = novelIntoCompanion(tSource);
      expect(result, tCompanion);
    });
  });

  group('volumeIntoCompanion', () {
    test('should convert sources.Volume into VolumesCompanion', () {
      final tSource = sources.Volume(
        index: 1,
        name: 'volume 1',
      );

      const tCompanion = VolumesCompanion(
        volumeIndex: Value(1),
        name: Value('volume 1'),
      );

      final result = volumeIntoCompanion(tSource);
      expect(result, tCompanion);
    });
  });
}
