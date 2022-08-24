import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../novel.dart';

part 'chapter_list_family.freezed.dart';

final chapterListFamily =
    Provider.autoDispose.family<List<ChapterListEntry>, NovelData>(
  (ref, data) {
    final map = <VolumeData, List<ChapterData>>{};
    for (final chapter in data.chapters) {
      map.putIfAbsent(chapter.volume, () => []).add(chapter);
    }

    final state = <ChapterListEntry>[];
    if (map.length == 1) {
      state.addAll(map.values.single.map(ChapterListEntry.chapter));
    } else {
      for (final entry in map.entries) {
        state.add(ChapterListEntry.volume(entry.key));
        state.addAll(entry.value.map(ChapterListEntry.chapter));
      }
    }

    return state;
  },
  name: 'ChapterListProvider',
);

@freezed
class ChapterListEntry with _$ChapterListEntry {
  factory ChapterListEntry.volume(VolumeData volume) = _VolumeEntry;
  factory ChapterListEntry.chapter(ChapterData chapter) = _ChapterEntry;
}
