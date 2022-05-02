import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

class SourceToChapterCompanionMapper
    implements Mapper<sources.Chapter, ChaptersCompanion> {
  @override
  ChaptersCompanion from(sources.Chapter input) {
    return ChaptersCompanion(
      chapterIndex: Value(input.index),
      title: Value(input.title),
      content: Value(input.content),
      url: Value(input.url),
      updated: Value(input.updated),
    );
  }
}
