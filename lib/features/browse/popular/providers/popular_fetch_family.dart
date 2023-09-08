import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;


final popularFetchFamily = StateNotifierProvider.autoDispose
    .family<PopularFetchNotifier, FetchInfo, CrawlerInfo>(
  (ref, crawler) => PopularFetchNotifier(
    ref: ref,
    state: FetchInfo.initial(),
    fetchPopular: ref.watch(fetchPopularProvider),
  ),
  name: 'PopularFetchProvider',
);

class PopularFetchNotifier extends StateNotifier<FetchInfo> {
  PopularFetchNotifier({
    required Ref ref,
    required FetchInfo state,
    required FetchPopular fetchPopular,
  })  : _ref = ref,
        _fetchPopular = fetchPopular,
        super(state);

  final Ref _ref;
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
          _ref.read(messageServiceProvider).showText(failure.message);
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
