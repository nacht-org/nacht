import 'package:chapturn/domain/domain.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../../../provider/provider.dart';
import '../model/chapter_info.dart';
import '../model/content_info.dart';

final chapterProvider = StateNotifierProvider.autoDispose
    .family<ChapterNotifier, ChapterInfo, Tuple2<ChapterData, CrawlerHolding>>(
  (ref, tuple) => ChapterNotifier(
    state: ChapterInfo.fromChapterData(tuple.value1, tuple.value2),
    chapterService: ref.watch(chapterServiceProvider),
  ),
  name: 'ContentProvider',
);

class ChapterNotifier extends StateNotifier<ChapterInfo> with LoggerMixin {
  ChapterNotifier({
    required ChapterInfo state,
    required ChapterService chapterService,
  })  : _chapterService = chapterService,
        super(state);

  final ChapterService _chapterService;

  Future<void> fetch() async {
    if (state.fetched) {
      return;
    }

    // TODO: check for crawler support
    final content = await _chapterService.fetchContent(
      state.crawlerHolding.crawler as sources.ParseNovel,
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
