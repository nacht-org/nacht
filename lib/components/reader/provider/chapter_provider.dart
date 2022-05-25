import 'package:chapturn/domain/domain.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../../../provider/provider.dart';
import '../model/chapter_info.dart';
import '../model/content_info.dart';

final chapterProvider = StateNotifierProvider.autoDispose
    .family<ChapterNotifier, ChapterInfo, ChapterInfo>(
  (ref, info) => ChapterNotifier(
    read: ref.read,
    state: info,
    chapterService: ref.watch(chapterServiceProvider),
  ),
  name: 'ContentProvider',
);

class ChapterNotifier extends StateNotifier<ChapterInfo> with LoggerMixin {
  ChapterNotifier({
    required Reader read,
    required ChapterInfo state,
    required ChapterService chapterService,
  })  : _read = read,
        _chapterService = chapterService,
        super(state);

  final Reader _read;
  final ChapterService _chapterService;

  Future<void> fetch() async {
    if (state.fetched) {
      return;
    }

    // TODO: check for crawler support
    final content = await _chapterService.fetchContent(
      state.crawlerInfo.crawler as sources.ParseNovel,
      state.data.url,
    );

    // The provider may be dismounted before fetch ends.
    if (!mounted) return;

    content.fold(
      (failure) => log.warning(failure.toString()),
      (data) => state = state.copyWith(
        content: ContentInfo.data(data),
        fetched: true,
      ),
    );
  }

  Future<void> readToEnd() async {
    // Limit readAt updates to once every 5 minutes
    if (state.data.readAt != null &&
        DateTime.now().difference(state.data.readAt!).inMinutes < 5) {
      return;
    }

    log.fine('updating read at to now');

    final oldReadAt = state.data.readAt;
    _readAt = DateTime.now();

    final result = await _chapterService.setReadAt([state.data], true);

    result.fold(
      (failure) {
        log.warning(failure);
        _readAt = oldReadAt;
      },
      (_) {
        _read(novelProvider(NovelInput(state.novel)).notifier)
            .setReadAt(state.data.id, state.data.readAt);
      },
    );
  }

  /// Helper setter to update [readAt] of chapter state
  set _readAt(DateTime? value) =>
      state = state.copyWith(data: state.data.copyWith(readAt: value));
}
