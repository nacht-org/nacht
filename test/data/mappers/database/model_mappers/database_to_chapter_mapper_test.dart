import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/database_mappers/model_mappers/database_to_chapter_mapper.dart';
import 'package:chapturn/domain/entities/novel/chapter_entity.dart';

import '../../mapper_helper.dart';

void main() {
  mapperGroup(
      name: 'DatabaseToChapterMapper',
      mapper: DatabaseToChapterMapper(),
      test: (mapper) {
        mapperTest(
          'db.Chapter',
          'ChapterEntity',
          from: Chapter(
            id: 2,
            chapterIndex: 2,
            title: 'my chapter',
            content: null,
            url: 'https://website.com/novel/123/1',
            updated: DateTime(2022, 4, 23),
            volumeId: 2,
          ),
          to: ChapterEntity(
            id: 2,
            index: 2,
            title: 'my chapter',
            content: null,
            url: 'https://website.com/novel/123/1',
            updated: DateTime(2022, 4, 23),
            volumeId: 2,
          ),
          mapper: mapper,
        );
      });
}
