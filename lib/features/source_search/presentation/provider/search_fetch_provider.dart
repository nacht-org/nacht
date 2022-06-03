import 'package:nacht/core/core.dart';
import 'package:nacht/features/browse/browse.dart';
import 'package:nacht/provider/provider.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';

final searchFetchProvider = StateNotifierProvider.autoDispose
    .family<SearchFetchNotifier, FetchInfo, CrawlerInfo>(
  (ref, holding) {
    var notifier = SearchFetchNotifier(
      read: ref.read,
      crawler: holding,
      fetchSearch: ref.watch(fetchSearchProvider),
    );

    return notifier;
  },
  name: 'SearchFetchProvider',
);

class SearchFetchNotifier extends StateNotifier<FetchInfo> with LoggerMixin {
  SearchFetchNotifier({
    required Reader read,
    required CrawlerInfo crawler,
    required FetchSearch fetchSearch,
  })  : _read = read,
        _crawler = crawler,
        _fetchSearch = fetchSearch,
        super(FetchInfo.initial());

  String _currentQuery = '';

  final Reader _read;
  final CrawlerInfo _crawler;
  final FetchSearch _fetchSearch;

  void restart() {
    state = FetchInfo.initial().copyWith(isLoading: true);
    next();
  }

  @override
  Future<void> next() {
    return fetch(_currentQuery);
  }

  Future<void> fetch(String query) async {
    if (_crawler.searchNotSupported) {
      log.warning('crawler search cancelled, not supported');
      return;
    }

    if (query == _currentQuery) {
      state = state.copyWith(isLoading: true);
    } else {
      _currentQuery = query;
      state = FetchInfo.initial().copyWith(isLoading: true);
    }

    final result = await _fetchSearch.execute(
      _crawler.instance as ParseSearch,
      _currentQuery,
      state.page,
    );

    result.fold(
      (failure) {
        if (state.page == 1) {
          state = state.copyWith(error: failure.message, isLoading: false);
        } else {
          state = state.copyWith(isLoading: false);
          _read(messageServiceProvider)
              .showText(failure.message ?? "Unexpected error");
        }
      },
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
