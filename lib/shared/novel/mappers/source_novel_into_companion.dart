import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

NovelsCompanion sourceNovelIntoCompanion(sources.Novel novel) {
  return NovelsCompanion(
    title: Value(novel.title),
    description: Value(novel.description.join('\n')),
    author: Value(novel.author),
    coverUrl: Value(novel.thumbnailUrl),
    url: Value(novel.url),
    statusId: Value(StatusSeed.fromStatus(novel.status)),
    lang: Value(novel.lang),
    workTypeId: Value(WorkTypeSeed.fromWorkType(novel.workType)),
    readingDirectionId: Value(
      ReadingDirectionSeed.fromReadingDirection(novel.readingDirection),
    ),
  );
}
