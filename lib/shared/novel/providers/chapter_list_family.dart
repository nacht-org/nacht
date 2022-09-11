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
      reload();
    }
  }

  Future<void> reload() async {
    state = state.copyWith(
      chapters: await _getChapters.execute(_novelId),
      isLoaded: true,
    );
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

  Future<void> markAsRead(int index) async {
    final chapter = state.chapters[index];
    if (chapter.readAt != null &&
        DateTime.now().difference(chapter.readAt!).inMinutes < 5) {
      return;
    }

    log.fine('updating ${chapter.id} to read at to now');

    final oldReadAt = chapter.readAt;
    final newData = chapter.copyWith(readAt: DateTime.now());

    state = state.copyWith(chapters: [
      for (final c in state.chapters)
        if (c.id == chapter.id) newData else c
    ]);

    final failure = await _setReadAt.execute([newData], true);
    if (failure != null) {
      log.warning(failure);
      state = state.copyWith(chapters: [
        for (final c in state.chapters)
          if (c.id == chapter.id) chapter.copyWith(readAt: oldReadAt) else c
      ]);
    }
  }
}
