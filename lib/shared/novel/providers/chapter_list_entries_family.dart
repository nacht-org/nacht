import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/preferences/chapter_list/chapter_list.dart';

import '../models/models.dart';

final _chapterListMapFamily =
    Provider.family<Map<VolumeData, List<ChapterData>>, List<ChapterData>>(
        (ref, data) {
  final map = <VolumeData, List<ChapterData>>{};
  for (final chapter in data) {
    map.putIfAbsent(chapter.volume, () => []).add(chapter);
  }

  return map;
});

final chapterListEntriesFamily =
    Provider.family<List<ChapterListEntry>, List<ChapterData>>((ref, data) {
  final map = ref.watch(_chapterListMapFamily(data));
  final pref = ref.watch(chapterListPreferencesProvider);

  final state = <ChapterListEntry>[];
  if (map.length == 1) {
    final chapters = map.values.single..sort(_compare(pref.order));
    state.addAll(chapters.map(ChapterListEntry.chapter));
  } else {
    final entries = _sortEntries(map, pref.order);
    for (final entry in entries) {
      state.add(ChapterListEntry.volume(entry.key));
      final chapters = entry.value..sort(_compare(pref.order));
      state.addAll(chapters.map(ChapterListEntry.chapter));
    }
  }

  return state;
});

typedef _KeyParam = MapEntry<VolumeData, List<ChapterData>>;
typedef _MapCompare = int Function(_KeyParam, _KeyParam);

List<_KeyParam> _sortEntries(
  Map<VolumeData, List<ChapterData>> map,
  OrderPreference order,
) {
  final _MapCompare compare;
  switch (order) {
    case OrderPreference.ascending:
      compare = (a, b) => a.key.index.compareTo(b.key.index);
      break;
    case OrderPreference.descending:
      compare = (a, b) => b.key.index.compareTo(a.key.index);
      break;
  }

  return map.entries.toList()..sort(compare);
}

int Function(ChapterData, ChapterData)? _compare(OrderPreference order) {
  switch (order) {
    case OrderPreference.descending:
      return (a, b) => b.index.compareTo(a.index);
    case OrderPreference.ascending:
      return (a, b) => a.index.compareTo(b.index);
  }
}
