import 'package:nacht/domain/domain.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../model/reader_page_info.dart';

final readerPageProvider = StateNotifierProvider.autoDispose
    .family<ReaderPageNotifier, ReaderPageInfo, ReaderPageInfo>(
  (ref, info) => ReaderPageNotifier(
    read: ref.read,
    state: info,
    chapterService: ref.watch(chapterServiceProvider),
  ),
  name: 'ReaderPageProvider',
);

class ReaderPageNotifier extends StateNotifier<ReaderPageInfo>
    with LoggerMixin {
  ReaderPageNotifier({
    required Reader read,
    required ReaderPageInfo state,
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
      state.crawler.instance as sources.ParseNovel,
      state.chapter.url,
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
}
