import 'package:chapturn_sources/chapturn_sources.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/mapper.dart';
import '../../../datasources/local/database.dart' as db;

class DatabaseToNovelMapper implements Mapper<db.Novel, NovelEntity> {
  DatabaseToNovelMapper({
    required this.statusMapper,
    required this.readingDirectionMapper,
    required this.workTypeMapper,
  });

  final Mapper<int, ReadingDirection> readingDirectionMapper;
  final Mapper<int, NovelStatus> statusMapper;
  final Mapper<int, WorkType> workTypeMapper;

  @override
  NovelEntity map(db.Novel input) {
    return NovelEntity(
      id: input.id,
      title: input.title,
      url: input.url,
      author: input.author,
      description: input.description.split('\n'),
      coverUrl: input.coverUrl,
      status: statusMapper.map(input.statusId),
      lang: input.lang,
      volumes: [],
      metadata: [],
      workType: workTypeMapper.map(input.workTypeId),
      readingDirection: readingDirectionMapper.map(input.readingDirectionId),
    );
  }
}
