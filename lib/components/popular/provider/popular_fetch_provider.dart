import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import 'crawler_info_provider.dart';

part 'popular_fetch_provider.freezed.dart';

final popularFetchProvider = StateNotifierProvider.autoDispose
    .family<PopularFetchNotifier, FetchInfo, CrawlerInfo>(
  (ref, crawlerInfo) => PopularFetchNotifier(
    state: FetchInfo.initial(),
    crawlerInfo: crawlerInfo,
    sourceService: ref.watch(sourceServiceProvider),
  ),
  name: 'PopularFetchProvider',
);

class PopularFetchNotifier extends StateNotifier<FetchInfo> {
  PopularFetchNotifier({
    required FetchInfo state,
    required CrawlerInfo crawlerInfo,
    required SourceService sourceService,
  })  : _crawlerInfo = crawlerInfo,
        _sourceService = sourceService,
        super(state);

  final CrawlerInfo _crawlerInfo;
  final SourceService _sourceService;

  Future<void> fetch() async {
    assert(_crawlerInfo.popularParser != null);

    state = state.copyWith(isLoading: true);

    final result = await _sourceService.popular(
      _crawlerInfo.popularParser!,
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

@freezed
class FetchInfo with _$FetchInfo {
  const factory FetchInfo({
    required List<PartialNovelData> data,
    required bool isLoading,
    required int page,
  }) = _PopularInfo;

  factory FetchInfo.initial() {
    return const FetchInfo(
      data: [],
      isLoading: true,
      page: 1,
    );
  }

  bool get isInitial {
    return isLoading && page == 1;
  }

  const FetchInfo._();
}
