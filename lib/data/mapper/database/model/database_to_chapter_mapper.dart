import '../../../../domain/entities/novel/chapter_entity.dart';
import '../../../../domain/mapper.dart';
import '../../../datasources/local/database.dart';

class DatabaseToChapterMapper implements Mapper<Chapter, ChapterEntity> {
  @override
  ChapterEntity from(Chapter input) {
    return ChapterEntity(
      id: input.id,
      index: input.chapterIndex,
      title: input.title,
      content: input.content,
      url: input.url,
      updated: input.updated,
      volumeId: input.volumeId,
    );
  }
}
