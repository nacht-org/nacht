import 'package:chapturn_sources/chapturn_sources.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/mapper.dart';
import '../../datasources/local/database.dart' as db;

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
  NovelEntity map(db.Novel model) {
    return NovelEntity(
      id: model.id,
      title: model.title,
      url: model.url,
      author: model.author,
      description: model.description.split('\n'),
      thumbnailUrl: model.thumbnailUrl,
      status: statusMapper.map(model.statusId),
      lang: model.lang,
      volumes: [],
      metadata: [],
      workType: workTypeMapper.map(model.workTypeId),
      readingDirection: readingDirectionMapper.map(model.readingDirectionId),
    );
  }
}
