import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

ChaptersCompanion sourceChapterIntoCompanion(sources.Chapter chapter) {
  return ChaptersCompanion(
    chapterIndex: Value(chapter.index),
    title: Value(chapter.title),
    url: Value(chapter.url),
    updated: chapter.updated == null
        ? const Value.absent()
        : Value(chapter.updated!),
  );
}
