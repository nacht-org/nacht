import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

final readerPageFamily = StateNotifierProvider.autoDispose
    .family<ReaderPageNotifier, ReaderPageInfo, ReaderPageInfo>(
  (ref, info) => ReaderPageNotifier(
    state: info,
    fetchChapterContent: ref.watch(fetchChapterContentProvider),
  ),
  name: 'ReaderPageProvider',
);

class ReaderPageNotifier extends StateNotifier<ReaderPageInfo>
    with LoggerMixin {
  ReaderPageNotifier({
    required ReaderPageInfo state,
    required FetchChapterContent fetchChapterContent,
  })  : _fetchChapterContent = fetchChapterContent,
        super(state);

  final FetchChapterContent _fetchChapterContent;

  Future<void> fetch(CrawlerInfo? crawler) async {
    if (state.fetched) {
      log.warning('chapter content already fetched.');
      return;
    }

    // Make sure loading screen is being shown.
    state = state.copyWith(content: const ContentInfo.loading());

    // TODO: check for crawler support
    final content =
        await _fetchChapterContent.execute(crawler!.isolate, state.chapter.url);

    // The provider may be dismounted before fetch ends.
    if (!mounted) return;

    content.fold(
      (failure) {
        log.warning(failure.message);
        state = state.copyWith(
          content: ContentInfo.error(failure.message),
        );
      },
      (data) => state = state.copyWith(
        content: ContentInfo.data(data),
        fetched: true,
      ),
    );
  }
}
