import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/domain/entities/novel_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../../../domain/mapper.dart';

class DatabaseToNovelMapper implements Mapper<db.Novel, NovelEntity> {
  final Mapper<int, NovelStatus> statusMapper;
  final Mapper<int, ReadingDirection> readingDirectionMapper;
  final Mapper<int, WorkType> workTypeMapper;

  DatabaseToNovelMapper({
    required this.statusMapper,
    required this.readingDirectionMapper,
    required this.workTypeMapper,
  });

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
