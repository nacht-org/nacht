import 'package:nacht/components/browse/model/fetch_info.dart';
import 'package:nacht/domain/domain.dart';
import 'package:nacht/provider/provider.dart';
import 'package:nacht_sources/nacht_sources.dart' show ParsePopular;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final popularFetchProvider = StateNotifierProvider.autoDispose
    .family<PopularFetchNotifier, FetchInfo, CrawlerInfo>(
  (ref, crawler) => PopularFetchNotifier(
    state: FetchInfo.initial(),
    crawler: crawler,
    sourceService: ref.watch(sourceServiceProvider),
  ),
  name: 'PopularFetchProvider',
);

class PopularFetchNotifier extends StateNotifier<FetchInfo> {
  PopularFetchNotifier({
    required FetchInfo state,
    required CrawlerInfo crawler,
    required SourceService sourceService,
  })  : _crawler = crawler,
        _sourceService = sourceService,
        super(state);

  final CrawlerInfo _crawler;
  final SourceService _sourceService;

  Future<void> fetch() async {
    assert(_crawler.popularSupported);

    state = state.copyWith(isLoading: true);

    final result = await _sourceService.popular(
      _crawler.instance as ParsePopular,
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
