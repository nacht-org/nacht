import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/logger/logger.dart';
import 'package:nacht/features/features.dart';

import '../models/models.dart';
import '../services/services.dart';

final chapterListFamily = StateNotifierProvider.autoDispose
    .family<ChapterListNotifier, ChapterListInfo, int>(
  (ref, novelId) {
    final notifier = ChapterListNotifier(
      ref: ref,
      state: ChapterListInfo(chapters: [], isLoaded: false),
      novelId: novelId,
      watchChapterList: ref.watch(watchChapterListProvider),
      setReadAt: ref.watch(setReadAtProvider),
    );

    ref.onDispose(() {
      notifier.chapterSubscription?.cancel();
    });

    return notifier;
  },
  name: 'ChapterListProvider',
);

class ChapterListNotifier extends StateNotifier<ChapterListInfo>
    with LoggerMixin {
  ChapterListNotifier({
    required Ref ref,
    required ChapterListInfo state,
    required int novelId,
    required WatchChapterList watchChapterList,
    required SetReadAt setReadAt,
  })  : _ref = ref,
        _novelId = novelId,
        _watchChapterList = watchChapterList,
        _setReadAt = setReadAt,
        super(state);

  final Ref _ref;
  final int _novelId;
  final WatchChapterList _watchChapterList;
  final SetReadAt _setReadAt;

  late StreamSubscription<List<ChapterData>>? chapterSubscription;

  Future<void> init() async {
    if (!state.isLoaded) {
      final chapterStream =
          _watchChapterList.call(_novelId).asBroadcastStream();
      final chapters = await chapterStream.first;

      chapterSubscription = chapterStream.listen((chapters) {
        state = state.copyWith(chapters: chapters);
      });

      state = state.copyWith(
        chapters: chapters,
        isLoaded: true,
      );
    }
  }

  Future<void> setReadAt(Set<int> ids, bool isRead) async {
    final failure = await _setReadAt.execute(ids, isRead);
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

    final incognito = _ref.read(incognitoProvider);
    if (incognito) return;

    log.fine('updating ${chapter.id} to read at to now');

    final oldReadAt = chapter.readAt;
    final newData = chapter.copyWith(readAt: DateTime.now());

    state = state.copyWith(chapters: [
      for (final c in state.chapters)
        if (c.id == chapter.id) newData else c
    ]);

    final failure = await _setReadAt.execute([newData.id], true);
    if (failure != null) {
      log.warning(failure);
      state = state.copyWith(chapters: [
        for (final c in state.chapters)
          if (c.id == chapter.id) chapter.copyWith(readAt: oldReadAt) else c
      ]);
    }
  }
}
