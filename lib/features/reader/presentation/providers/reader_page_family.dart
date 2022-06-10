import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation.dart';

final readerPageFamily = StateNotifierProvider.autoDispose
    .family<ReaderPageNotifier, ReaderPageInfo, ReaderPageInfo>(
  (ref, info) => ReaderPageNotifier(
    read: ref.read,
    state: info,
    fetchChapterContent: ref.watch(fetchChapterContentProvider),
  ),
  name: 'ReaderPageProvider',
);

class ReaderPageNotifier extends StateNotifier<ReaderPageInfo>
    with LoggerMixin {
  ReaderPageNotifier({
    required Reader read,
    required ReaderPageInfo state,
    required FetchChapterContent fetchChapterContent,
  })  : _read = read,
        _fetchChapterContent = fetchChapterContent,
        super(state);

  final Reader _read;
  final FetchChapterContent _fetchChapterContent;

  Future<void> fetch() async {
    if (state.fetched) {
      log.warning('chapter content already fetched.');
      return;
    }

    // TODO: check for crawler support
    final content = await _fetchChapterContent.execute(
      state.crawler.instance as sources.ParseNovel,
      state.chapter.url,
    );

    // The provider may be dismounted before fetch ends.
    if (!mounted) return;

    content.fold(
      (failure) {
        log.warning(failure.message);
        _read(messageServiceProvider).showText(failure.message);
      },
      (data) => state = state.copyWith(
        content: ContentInfo.data(data),
        fetched: true,
      ),
    );
  }
}
