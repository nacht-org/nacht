import 'package:nacht/domain/domain.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../model/chapter_info.dart';
import '../model/content_info.dart';

final readerProvider = StateNotifierProvider.autoDispose
    .family<ReaderNotifier, ChapterInfo, ChapterInfo>(
  (ref, info) => ReaderNotifier(
    read: ref.read,
    state: info,
    chapterService: ref.watch(chapterServiceProvider),
  ),
  name: 'ContentProvider',
);

class ReaderNotifier extends StateNotifier<ChapterInfo> with LoggerMixin {
  ReaderNotifier({
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
}
