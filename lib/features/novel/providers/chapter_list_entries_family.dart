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
    final chapters = map.values.single
      ..sort(_getCompareTo(pref.order, pref.sort));
    state.addAll(chapters.map(ChapterListEntry.chapter));
  } else {
    final entries = _sortEntries(map, pref.order);
    for (final entry in entries) {
      state.add(ChapterListEntry.volume(entry.key));

      final chapters = entry.value..sort(_getCompareTo(pref.order, pref.sort));
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

Comparator<ChapterData> _getCompareTo(
    OrderPreference order, SortPreference sort) {
  switch (order) {
    case OrderPreference.ascending:
      return (a, b) => _compare(sort, a, b);
    case OrderPreference.descending:
      return (a, b) => _compare(sort, b, a);
  }
}

int _compare(SortPreference sort, ChapterData a, ChapterData b) {
  switch (sort) {
    case SortPreference.source:
      return a.index.compareTo(b.index);
    case SortPreference.dateUpload:
      if (a.updated == null && b.updated == null) {
        return 0;
      } else if (a.updated == null) {
        return 1;
      } else if (b.updated == null) {
        return -1;
      } else {
        return a.updated!.compareTo(b.updated!);
      }
  }
}
