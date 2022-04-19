import 'package:chapturn/domain/entities/partial_novel_entity.dart';
import 'package:chapturn/domain/usecases/get_popular_novels.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  }) : super(const PopularPageLoaderState.loading());

  final GetPopularNovels getPopularNovels;
  final Crawler crawler;
  final bool hasPopularFeature;

  int _page = 1;

  Future<void> load() async {
    state = const PopularPageLoaderState.loading();
    final result = await getPopularNovels.execute(crawler as NovelPopular);
    state = PopularPageLoaderState.data(result.fold(
      (failure) => [], // TODO: handle failure
      (data) => data,
    ));
  }
}
