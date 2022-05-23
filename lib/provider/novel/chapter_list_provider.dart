import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';

part 'chapter_list_provider.freezed.dart';

final chapterListProvider = StateNotifierProvider.autoDispose
    .family<ChapterListNotifier, List<ChapterListEntry>, NovelData>(
  (ref, data) {
    final state = <ChapterListEntry>[];
    if (data.volumes.length == 1) {
      state.addAll(data.volumes.single.chapters.map(ChapterListEntry.chapter));
    } else {
      for (final volume in data.volumes) {
        state.add(ChapterListEntry.volume(volume));
        state.addAll(volume.chapters.map(ChapterListEntry.chapter));
      }
    }

    return ChapterListNotifier(state: state);
  },
  name: 'ChapterListProvider',
);

class ChapterListNotifier extends StateNotifier<List<ChapterListEntry>> {
  ChapterListNotifier({
    required List<ChapterListEntry> state,
  }) : super(state);
}

@freezed
class ChapterListEntry with _$ChapterListEntry {
  factory ChapterListEntry.volume(VolumeData volume) = _VolumeEntry;
  factory ChapterListEntry.chapter(ChapterData chapter) = _ChapterEntry;
}
