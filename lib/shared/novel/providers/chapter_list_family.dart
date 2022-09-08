import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/logger/logger.dart';
import 'package:nacht/shared/novel/services/get_chapters.dart';

import '../novel.dart';

final chapterListFamily = StateNotifierProvider.autoDispose
    .family<ChapterListNotifier, ChapterListInfo, int>(
  (ref, novelId) => ChapterListNotifier(
    state: ChapterListInfo(chapters: [], isLoaded: false),
    novelId: novelId,
    getChapters: ref.watch(getChaptersProvider),
    setReadAt: ref.watch(setReadAtProvider),
  ),
  name: 'ChapterListProvider',
);

class ChapterListNotifier extends StateNotifier<ChapterListInfo>
    with LoggerMixin {
  ChapterListNotifier({
    required ChapterListInfo state,
    required int novelId,
    required GetChapters getChapters,
    required SetReadAt setReadAt,
  })  : _novelId = novelId,
        _getChapters = getChapters,
        _setReadAt = setReadAt,
        super(state);

  final int _novelId;
  final GetChapters _getChapters;
  final SetReadAt _setReadAt;

  Future<void> init() async {
    if (!state.isLoaded) {
      state = state.copyWith(
        chapters: await _getChapters.execute(_novelId),
        isLoaded: true,
      );
    }
  }

  Future<void> setReadAt(Set<int> ids, bool isRead) async {
    final chapters =
        state.chapters.where((element) => ids.contains(element.id)).toList();

    final failure = await _setReadAt.execute(chapters, isRead);
    if (failure != null) {
      log.warning(failure);
      return;
    }

    final readAt = isRead ? DateTime.now() : null;

    state = state.copyWith(
      chapters: [
        for (final c in state.chapters)
          if (ids.contains(c.id)) c.copyWith(readAt: readAt) else c
      ],
    );
  }
}
