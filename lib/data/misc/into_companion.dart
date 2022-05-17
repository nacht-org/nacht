import 'dart:convert';

import 'package:chapturn/data/data.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

ChaptersCompanion chapterIntoCompanion(sources.Chapter chapter) {
  return ChaptersCompanion(
    chapterIndex: Value(chapter.index),
    title: Value(chapter.title),
    content: chapter.content == null
        ? const Value.absent()
        : Value(chapter.content!),
    url: Value(chapter.url),
    updated: chapter.updated == null
        ? const Value.absent()
        : Value(chapter.updated!),
  );
}

MetaEntriesCompanion metaDataIntoCompanion(sources.MetaData input) {
  return MetaEntriesCompanion(
    name: Value(input.name),
    value: Value(input.value),
    namespaceId: Value(NamespaceSeed.fromNamespace(input.namespace)),
    others: Value(input.others.isEmpty ? null : json.encode(input.others)),
  );
}

NovelsCompanion novelIntoCompanion(sources.Novel input) {
  return NovelsCompanion(
    title: Value(input.title),
    description: Value(input.description.join('\n')),
    author: Value(input.author),
    coverUrl: Value(input.thumbnailUrl),
    url: Value(input.url),
    statusId: Value(StatusSeed.fromStatus(input.status)),
    lang: Value(input.lang),
    workTypeId: Value(WorkTypeSeed.fromWorkType(input.workType)),
    readingDirectionId: Value(
      ReadingDirectionSeed.fromReadingDirection(input.readingDirection),
    ),
  );
}

VolumesCompanion volumeIntoCompanion(sources.Volume input) {
  return VolumesCompanion(
    volumeIndex: Value(input.index),
    name: Value(input.name),
  );
}
