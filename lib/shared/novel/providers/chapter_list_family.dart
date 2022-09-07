import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/novel/services/get_chapters.dart';

import '../novel.dart';

final chapterListFamily = StateNotifierProvider.autoDispose
    .family<ChapterListNotifier, ChapterListInfo, int>(
  (ref, novelId) => ChapterListNotifier(
    state: ChapterListInfo(chapters: [], isLoaded: false),
    novelId: novelId,
    getChapters: ref.watch(getChaptersProvider),
  ),
  name: 'ChapterListProvider',
);

class ChapterListNotifier extends StateNotifier<ChapterListInfo> {
  ChapterListNotifier({
    required ChapterListInfo state,
    required int novelId,
    required GetChapters getChapters,
  })  : _novelId = novelId,
        _getChapters = getChapters,
        super(state);

  final int _novelId;
  final GetChapters _getChapters;

  Future<void> init() async {
    if (!state.isLoaded) {
      state = state.copyWith(
        chapters: await _getChapters.execute(_novelId),
        isLoaded: true,
      );
    }
  }
}
