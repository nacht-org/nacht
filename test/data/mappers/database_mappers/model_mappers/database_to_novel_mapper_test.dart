import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/database_mappers/model_mappers/database_to_novel_mapper.dart';
import 'package:chapturn/data/models/reading_direction.dart';
import 'package:chapturn/data/models/status.dart';
import 'package:chapturn/data/models/work_type.dart';
import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mapper_helper.dart';
import './database_to_novel_mapper_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<Mapper<int, sources.NovelStatus>>(as: #MockStatusMapper),
    MockSpec<Mapper<int, sources.WorkType>>(as: #MockWorkTypeMapper),
    MockSpec<Mapper<int, sources.ReadingDirection>>(
        as: #MockReadingDirectionMapper),
  ],
)
void main() {
  Mapper<int, sources.NovelStatus> mockStatusMapper = MockStatusMapper();
  Mapper<int, sources.WorkType> mockWorkTypeMapper = MockWorkTypeMapper();
  Mapper<int, sources.ReadingDirection> mockReadingDirectionMapper =
      MockReadingDirectionMapper();
  DatabaseToNovelMapper mapper = DatabaseToNovelMapper(
    statusMapper: mockStatusMapper,
    readingDirectionMapper: mockReadingDirectionMapper,
    workTypeMapper: mockWorkTypeMapper,
  );

  group('DatabaseToNovelMapper', () {
    mapperTest(
      'db.Novel',
      'NovelEntity',
      from: Novel(
        id: 10,
        title: 'my novel',
        author: 'my name',
        coverUrl: 'https://website.com/novel/123/cover.jpg',
        coverId: 1,
        url: 'https://website.com/novel/123',
        description: 'first paragraph\nsecond paragraph',
        lang: 'en',
        readingDirectionId: ReadingDirectionSeed.ltr,
        workTypeId: WorkTypeSeed.translationMtl,
        statusId: StatusSeed.completed,
        favourite: true,
      ),
      to: NovelEntity(
        id: 10,
        title: 'my novel',
        author: 'my name',
        coverUrl: 'https://website.com/novel/123/cover.jpg',
        url: 'https://website.com/novel/123',
        description: ['first paragraph', 'second paragraph'],
        lang: 'en',
        readingDirection: sources.ReadingDirection.ltr,
        workType: const sources.TranslatedWork.mtl(),
        status: sources.NovelStatus.completed,
        metadata: [],
        volumes: [],
        favourite: true,
      ),
      stub: () {
        when(mockStatusMapper.map(StatusSeed.completed))
            .thenReturn(sources.NovelStatus.completed);
        when(mockWorkTypeMapper.map(WorkTypeSeed.translationMtl))
            .thenReturn(const sources.TranslatedWork.mtl());
        when(mockReadingDirectionMapper.map(ReadingDirectionSeed.ltr))
            .thenReturn(sources.ReadingDirection.ltr);
      },
      mapper: mapper,
    );
  });
}
