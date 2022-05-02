import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

import '../../../../domain/mapper.dart';
import '../../../datasources/local/database.dart';

class SourceToNovelCompanionMapper
    extends Mapper<sources.Novel, NovelsCompanion> {
  SourceToNovelCompanionMapper({
    required this.statusMapper,
    required this.workTypeMapper,
    required this.readingDirectionMapper,
  });

  final Mapper<sources.ReadingDirection, int> readingDirectionMapper;
  final Mapper<sources.NovelStatus, int> statusMapper;
  final Mapper<sources.WorkType, int> workTypeMapper;

  @override
  NovelsCompanion from(sources.Novel input) {
    return NovelsCompanion(
      title: Value(input.title),
      description: Value(input.description.join('\n')),
      author: Value(input.author),
      coverUrl: Value(input.thumbnailUrl),
      url: Value(input.url),
      statusId: Value(statusMapper.from(input.status)),
      lang: Value(input.lang),
      workTypeId: Value(workTypeMapper.from(input.workType)),
      readingDirectionId:
          Value(readingDirectionMapper.from(input.readingDirection)),
    );
  }
}
