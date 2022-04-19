import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/domain/entities/novel_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../mapper.dart';

class NovelDatabaseMapper implements MapFrom<NovelEntity, db.Novel> {
  final MapFrom<NovelStatus, int> statusMapper;
  final MapFrom<ReadingDirection, int> readingDirectionMapper;
  final MapFrom<WorkType, int> workTypeMapper;

  NovelDatabaseMapper({
    required this.statusMapper,
    required this.readingDirectionMapper,
    required this.workTypeMapper,
  });

  @override
  NovelEntity mapFrom(db.Novel model) {
    return NovelEntity(
      id: model.id,
      title: model.title,
      url: model.url,
      author: model.author,
      description: model.description.split('\n'),
      thumbnailUrl: model.thumbnailUrl,
      status: statusMapper.mapFrom(model.statusId),
      lang: model.lang,
      volumes: [],
      metadata: [],
      workType: workTypeMapper.mapFrom(model.workTypeId),
      readingDirection:
          readingDirectionMapper.mapFrom(model.readingDirectionId),
    );
  }
}
