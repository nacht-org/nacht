import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';

part 'intermediate_provider.freezed.dart';

final intermediateProvider = StateNotifierProvider.autoDispose
    .family<IntermediateNotifier, IntermediateState, NovelType>(
  (ref, data) => IntermediateNotifier(
    ref: ref,
    state: IntermediateState(novel: data, error: null),
    fetchNovel: ref.watch(fetchNovelProvider),
    getNovelByUrl: ref.watch(getNovelByUrlProvider),
  ),
);

@freezed
class IntermediateState with _$IntermediateState {
  factory IntermediateState({
    required NovelType novel,
    required String? error,
  }) = _IntermediateState;

  IntermediateState._();

  bool get isComplete {
    return novel.when(
      url: (_) => false,
      partial: (_) => false,
      novel: (_) => true,
    );
  }
}

class IntermediateNotifier extends StateNotifier<IntermediateState>
    with LoggerMixin {
  IntermediateNotifier({
    required Ref ref,
    required IntermediateState state,
    required FetchNovel fetchNovel,
    required GetNovelByUrl getNovelByUrl,
  })  : _ref = ref,
        _fetchNovel = fetchNovel,
        _getNovelByUrl = getNovelByUrl,
        super(state);

  final Ref _ref;

  final FetchNovel _fetchNovel;
  final GetNovelByUrl _getNovelByUrl;

  Future<void> fetch(CrawlerInfo? crawler) async {
    if (crawler == null) {
      _ref.read(messageServiceProvider).showText('Unable to parse.');
      return;
    }

    if (state.error != null) {
      state = state.copyWith(error: null);
    }

    final failure =
        (await _fetchNovel.execute(crawler.isolate, state.novel.url))
            .toNullable();

    if (failure != null) {
      state = state.copyWith(error: failure.message);
      log.warning(failure);
      return;
    }

    final result = await _getNovelByUrl.execute(state.novel.url);
    result.fold(
      (failure) {
        log.warning(failure);
        state = state.copyWith(error: failure.message);
      },
      (data) {
        state = state.copyWith(novel: NovelType.novel(data));
      },
    );
  }
}
