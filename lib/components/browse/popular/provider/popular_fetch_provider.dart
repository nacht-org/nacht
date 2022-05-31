import 'package:nacht/components/browse/model/fetch_info.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/domain/domain.dart';
import 'package:nacht/provider/provider.dart';
import 'package:nacht_sources/nacht_sources.dart' show ParsePopular;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final popularFetchProvider = StateNotifierProvider.autoDispose
    .family<PopularFetchNotifier, FetchInfo, CrawlerInfo>(
  (ref, crawler) => PopularFetchNotifier(
    read: ref.read,
    state: FetchInfo.initial(),
    crawler: crawler,
    sourceService: ref.watch(sourceServiceProvider),
  ),
  name: 'PopularFetchProvider',
);

class PopularFetchNotifier extends StateNotifier<FetchInfo> {
  PopularFetchNotifier({
    required Reader read,
    required FetchInfo state,
    required CrawlerInfo crawler,
    required SourceService sourceService,
  })  : _read = read,
        _crawler = crawler,
        _sourceService = sourceService,
        super(state);

  final Reader _read;
  final CrawlerInfo _crawler;
  final SourceService _sourceService;

  void restart() {
    state = FetchInfo.initial();
    fetch();
  }

  Future<void> fetch() async {
    assert(_crawler.popularSupported);

    state = state.copyWith(isLoading: true);

    final result = await _sourceService.popular(
      _crawler.instance as ParsePopular,
      state.page,
    );

    // FIXME: mounted check.

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
