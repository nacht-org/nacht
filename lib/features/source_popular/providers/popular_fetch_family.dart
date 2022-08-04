import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../services/fetch_popular.dart';

final popularFetchFamily = StateNotifierProvider.autoDispose
    .family<PopularFetchNotifier, FetchInfo, CrawlerInfo>(
  (ref, crawler) => PopularFetchNotifier(
    read: ref.read,
    state: FetchInfo.initial(),
    fetchPopular: ref.watch(fetchPopularProvider),
  ),
  name: 'PopularFetchProvider',
);

class PopularFetchNotifier extends StateNotifier<FetchInfo> {
  PopularFetchNotifier({
    required Reader read,
    required FetchInfo state,
    required FetchPopular fetchPopular,
  })  : _read = read,
        _fetchPopular = fetchPopular,
        super(state);

  final Reader _read;
  final FetchPopular _fetchPopular;

  void restart(CrawlerInfo crawler) {
    state = FetchInfo.initial();
    next(crawler);
  }

  Future<void> next(CrawlerInfo crawler) async {
    assert(crawler.isSupported(sources.Feature.popular));

    state = state.copyWith(isLoading: true);

    final result = await _fetchPopular.execute(crawler.isolate, state.page);

    // FIXME: mounted check.

    result.fold(
      (failure) {
        if (state.page == 1) {
          state = state.copyWith(error: failure.message, isLoading: false);
        } else {
          state = state.copyWith(isLoading: false);
          _read(messageServiceProvider).showText(failure.message);
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
