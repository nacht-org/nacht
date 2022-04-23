import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/mappers.dart';
import 'package:chapturn/data/models/reading_direction.dart';
import 'package:chapturn/data/models/status.dart';
import 'package:chapturn/data/models/work_type.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mapper_helper.dart';
import './source_to_novel_companion_mapper_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<Mapper<sources.NovelStatus, int>>(as: #MockStatusMapper),
    MockSpec<Mapper<sources.WorkType, int>>(as: #MockWorkTypeMapper),
    MockSpec<Mapper<sources.ReadingDirection, int>>(
        as: #MockReadingDirectionMapper),
  ],
)
void main() {
  final mockStatusMapper = MockStatusMapper();
  final mockWorkTypeMapper = MockWorkTypeMapper();
  final mockReadingDirectionMapper = MockReadingDirectionMapper();

  mapperGroup<sources.Novel, NovelsCompanion>(
    name: 'SourceToNovelCompanionMapper',
    mapper: SourceToNovelCompanionMapper(
      statusMapper: mockStatusMapper,
      workTypeMapper: mockWorkTypeMapper,
      readingDirectionMapper: mockReadingDirectionMapper,
    ),
    test: (mapper) {
      mapperTest<sources.Novel, NovelsCompanion>(
        'sources.Novel',
        'NovelsCompanion',
        from: sources.Novel(
          title: 'my novel',
          description: ['in', 'many', 'words'],
          author: 'my name',
          url: 'https://website.com/novel/123',
          thumbnailUrl: 'https://website.com/novel/123/cover.jpg',
          lang: 'en',
          status: sources.NovelStatus.ongoing,
          workType: const sources.OriginalWork(),
          readingDirection: sources.ReadingDirection.ltr,
        ),
        to: const NovelsCompanion(
          title: Value('my novel'),
          description: Value('in\nmany\nwords'),
          author: Value('my name'),
          url: Value('https://website.com/novel/123'),
          thumbnailUrl: Value('https://website.com/novel/123/cover.jpg'),
          lang: Value('en'),
          statusId: Value(StatusSeed.ongoing),
          workTypeId: Value(WorkTypeSeed.original),
          readingDirectionId: Value(ReadingDirectionSeed.ltr),
        ),
        stub: () {
          when(mockStatusMapper.map(sources.NovelStatus.ongoing))
              .thenReturn(StatusSeed.ongoing);
          when(mockWorkTypeMapper.map(const sources.OriginalWork()))
              .thenReturn(WorkTypeSeed.original);
          when(mockReadingDirectionMapper.map(sources.ReadingDirection.ltr))
              .thenReturn(ReadingDirectionSeed.ltr);
        },
        mapper: mapper,
      );
    },
  );
}
