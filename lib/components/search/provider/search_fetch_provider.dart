import 'package:chapturn/core/logger/logger.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import '../../browse/model/fetch_info.dart';

final searchFetchProvider = StateNotifierProvider.autoDispose
    .family<SearchFetchNotifier, FetchInfo, CrawlerHolding>(
  (ref, holding) {
    var notifier = SearchFetchNotifier(
      crawlerHolding: holding,
      sourceService: ref.watch(sourceServiceProvider),
    );

    return notifier;
  },
  name: 'SearchFetchProvider',
);

class SearchFetchNotifier extends StateNotifier<FetchInfo> with LoggerMixin {
  SearchFetchNotifier({
    required CrawlerHolding crawlerHolding,
    required SourceService sourceService,
  })  : _crawlerHolding = crawlerHolding,
        _sourceService = sourceService,
        super(FetchInfo.initial());

  String _query = '';

  final CrawlerHolding _crawlerHolding;
  final SourceService _sourceService;

  Future<void> fetch(String query) async {
    if (_crawlerHolding.searchNotSupported) {
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
      _crawlerHolding.crawler as ParseSearch,
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
