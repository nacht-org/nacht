import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/novel/get_popular_novels.dart';

part 'popular_page_loader_state.freezed.dart';

@freezed
class PopularPageLoaderState with _$PopularPageLoaderState {
  const factory PopularPageLoaderState.data(List<PartialNovelEntity> novels) =
      _PopularPageLoaderData;

  const factory PopularPageLoaderState.loading() = _PopularPageLoaderLoading;
}

class PopularPageLoaderController
    extends StateNotifier<PopularPageLoaderState> {
  PopularPageLoaderController({
    required this.getPopularNovels,
    required this.crawler,
    required this.hasPopularFeature,
  }) : super(const PopularPageLoaderState.data([]));

  final Crawler crawler;
  final GetPopularNovels getPopularNovels;
  final bool hasPopularFeature;

  int _page = 0;

  Future<void> loadNext() async {
    if (!hasPopularFeature || isRunning) {
      return;
    }

    _page++;
    state = const PopularPageLoaderState.loading();
    final result =
        await getPopularNovels.execute(crawler as ParsePopular, _page);
    state = PopularPageLoaderState.data(result.fold(
      (failure) => [], // TODO: handle failure
      (data) => data,
    ));
  }

  bool get isRunning {
    return state.map(
      data: (_) => false,
      loading: (_) => true,
    );
  }
}
