import 'package:chapturn/components/browse/model/fetch_info.dart';
import 'package:chapturn/domain/domain.dart';
import 'package:chapturn/provider/provider.dart';
import 'package:chapturn_sources/chapturn_sources.dart' show ParsePopular;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final popularFetchProvider = StateNotifierProvider.autoDispose
    .family<PopularFetchNotifier, FetchInfo, CrawlerHolding>(
  (ref, holding) => PopularFetchNotifier(
    state: FetchInfo.initial(),
    crawlerHolding: holding,
    sourceService: ref.watch(sourceServiceProvider),
  ),
  name: 'PopularFetchProvider',
);

class PopularFetchNotifier extends StateNotifier<FetchInfo> {
  PopularFetchNotifier({
    required FetchInfo state,
    required CrawlerHolding crawlerHolding,
    required SourceService sourceService,
  })  : _crawlerInfo = crawlerHolding,
        _sourceService = sourceService,
        super(state);

  final CrawlerHolding _crawlerInfo;
  final SourceService _sourceService;

  Future<void> fetch() async {
    assert(_crawlerInfo.popularSupported);

    state = state.copyWith(isLoading: true);

    final result = await _sourceService.popular(
      _crawlerInfo.crawler as ParsePopular,
      state.page,
    );

    // FIXME: mounted check.

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
