import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/mappers.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

import '../../mapper_helper.dart';

void main() {
  mapperGroup(
    name: 'SourceToChapterCompanionMapper',
    mapper: SourceToChapterCompanionMapper(),
    test: (mapper) {
      mapperTest(
        'sources.Chapter',
        'ChaptersCompanion',
        from: sources.Chapter(
          index: 2,
          title: 'my chapter',
          content: '<div>content</div>',
          url: 'https://website.com/novel/123/1',
          updated: DateTime(2022, 04, 23),
        ),
        to: ChaptersCompanion(
          chapterIndex: const Value(2),
          title: const Value('my chapter'),
          content: const Value('<div>content</div>'),
          url: const Value('https://website.com/novel/123/1'),
          updated: Value(DateTime(2022, 04, 23)),
        ),
        mapper: mapper,
      );

      mapperTest(
        'sources.Chapter',
        'ChaptersCompanion',
        suffix: 'partial',
        from: sources.Chapter(
          index: 2,
          title: 'my chapter',
          url: 'https://website.com/novel/123/1',
        ),
        to: const ChaptersCompanion(
          chapterIndex: Value(2),
          title: Value('my chapter'),
          content: Value(null),
          url: Value('https://website.com/novel/123/1'),
          updated: Value(null),
        ),
        mapper: mapper,
      );
    },
  );
}
