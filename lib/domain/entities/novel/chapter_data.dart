import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data.dart';
import 'volume_data.dart';

part 'chapter_data.freezed.dart';

@freezed
class ChapterData with _$ChapterData {
  factory ChapterData({
    required int id,
    required int index,
    required String title,
    required int? content,
    required String url,
    required DateTime? updated,
    required DateTime? readAt,
    required int novelId,
    required VolumeData volume,
  }) = _ChapterData;

  factory ChapterData.fromModel(Chapter chapter, VolumeData volume) {
    return ChapterData(
      id: chapter.id,
      index: chapter.chapterIndex,
      title: chapter.title,
      content: chapter.content,
      url: chapter.url,
      updated: chapter.updated,
      readAt: chapter.readAt,
      novelId: chapter.novelId,
      volume: volume,
    );
  }

  ChapterData._();
}
