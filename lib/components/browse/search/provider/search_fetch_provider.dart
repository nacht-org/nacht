import 'package:chapturn/components/browse/model/fetch_info.dart';
import 'package:chapturn/core/logger/logger.dart';
import 'package:chapturn/domain/domain.dart';
import 'package:chapturn/provider/provider.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchFetchProvider = StateNotifierProvider.autoDispose
    .family<SearchFetchNotifier, FetchInfo, CrawlerInfo>(
  (ref, holding) {
    var notifier = SearchFetchNotifier(
      crawlerInfo: holding,
      sourceService: ref.watch(sourceServiceProvider),
    );

    return notifier;
  },
  name: 'SearchFetchProvider',
);

class SearchFetchNotifier extends StateNotifier<FetchInfo> with LoggerMixin {
  SearchFetchNotifier({
    required CrawlerInfo crawlerInfo,
    required SourceService sourceService,
  })  : _crawlerInfo = crawlerInfo,
        _sourceService = sourceService,
        super(FetchInfo.initial());

  String _query = '';

  final CrawlerInfo _crawlerInfo;
  final SourceService _sourceService;

  Future<void> fetch(String query) async {
    if (_crawlerInfo.searchNotSupported) {
      log.warning('crawler search cancelled, not supported');
      return;
    }

    if (query == _query) {
      state = state.copyWith(isLoading: true);
    } else {
      _query = query;
      state = FetchInfo.initial().copyWith(isLoading: true);
    }

    final result = await _sourceService.search(
      _crawlerInfo.crawler as ParseSearch,
      _query,
      state.page,
    );

    result.fold(
      (failure) {},
      (data) {
        state = state.copyWith(
          data: [...state.data, ...data],
          isLoading: false,
          page: state.page + 1,
        );
      },
    );
  }
}
