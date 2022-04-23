import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

import '../../../domain/mapper.dart';
import '../../datasources/local/database.dart';

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
  NovelsCompanion map(sources.Novel input) {
    return NovelsCompanion(
      title: Value(input.title),
      description: Value(input.description.join('\n')),
      author: Value(input.author),
      thumbnailUrl: Value(input.thumbnailUrl),
      url: Value(input.url),
      statusId: Value(statusMapper.map(input.status)),
      lang: Value(input.lang),
      workTypeId: Value(workTypeMapper.map(input.workType)),
      readingDirectionId:
          Value(readingDirectionMapper.map(input.readingDirection)),
    );
  }
}
