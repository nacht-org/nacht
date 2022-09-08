import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

final chapterListEntriesFamily =
    Provider.family<List<ChapterListEntry>, List<ChapterData>>((ref, data) {
  final map = <VolumeData, List<ChapterData>>{};
  for (final chapter in data) {
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
});
