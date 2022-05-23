import 'package:chapturn/core/logger/logger.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import '../../browse/model/fetch_info.dart';
import '../search.dart';

final searchFetchProvider = StateNotifierProvider.autoDispose
    .family<SearchFetchNotifier, FetchInfo, CrawlerHolding>(
  (ref, holding) {
    var notifier = SearchFetchNotifier(
      crawlerHolding: holding,
      sourceService: ref.watch(sourceServiceProvider),
    );

    ref.listen<String>(searchTextProvider, (previous, next) {
      notifier.query = next;
    });

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

  set query(String value) {
    _query = value;
    state = FetchInfo.initial();
  }

  Future<void> fetch() async {
    if (_crawlerHolding.searchNotSupported) {
      log.warning('crawler search cancelled, not supported');
      return;
    }

    state = state.copyWith(isLoading: true);

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
