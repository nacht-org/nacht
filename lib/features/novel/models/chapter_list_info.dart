import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'chapter_list_info.freezed.dart';

@freezed
class ChapterListInfo with _$ChapterListInfo {
  factory ChapterListInfo({
    /// The chapters of the indexes.
    required List<ChapterData> chapters,

    /// Whether data has been loaded from database.
    required bool isLoaded,
  }) = _ChapterListInfo;

  ///
  Iterable<int> get ids => chapters.map((c) => c.id);

  ChapterListInfo._();
}

@freezed
class ChapterListEntry with _$ChapterListEntry {
  factory ChapterListEntry.volume(VolumeData volume) = _VolumeEntry;
  factory ChapterListEntry.chapter(ChapterData chapter) = _ChapterEntry;
}
