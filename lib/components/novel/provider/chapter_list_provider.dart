import 'package:chapturn/components/novel/provider/novel_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';

part 'chapter_list_provider.freezed.dart';

final chapterListProvider = StateNotifierProvider.autoDispose<
    ChapterListNotifier, List<ChapterListItem>>(
  (ref) {
    final data = ref.watch(novelProvider);
    final state = <ChapterListItem>[];
    if (data.volumes.length == 1) {
      state.addAll(data.volumes.single.chapters.map(ChapterListItem.chapter));
    } else {
      for (final volume in data.volumes) {
        state.add(ChapterListItem.volume(volume));
        state.addAll(volume.chapters.map(ChapterListItem.chapter));
      }
    }

    return ChapterListNotifier(state: state);
  },
  dependencies: [novelProvider],
  name: 'ChapterListProvider',
);

class ChapterListNotifier extends StateNotifier<List<ChapterListItem>> {
  ChapterListNotifier({
    required List<ChapterListItem> state,
  }) : super(state);
}

@freezed
class ChapterListItem with _$ChapterListItem {
  factory ChapterListItem.volume(VolumeData volume) = _VolumeListItem;
  factory ChapterListItem.chapter(ChapterData chapter) = _ChapterListItem;
}
