import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart';

part 'intermediate_provider.freezed.dart';

final intermediateProvider = StateNotifierProvider.autoDispose
    .family<IntermediateNotifier, IntermediateState, NovelType>(
  (ref, data) {
    final crawlerFactory = ref.watch(crawlerFactoryFamily(data.url));
    final crawler = crawlerFactory != null
        ? ref.watch(crawlerFamily(crawlerFactory))
        : null;

    return IntermediateNotifier(
      read: ref.read,
      state: IntermediateState(novel: data, error: null),
      crawler: crawler,
      fetchNovel: ref.watch(fetchNovelProvider),
      getNovelByUrl: ref.watch(getNovelByUrlProvider),
    );
  },
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
    required Reader read,
    required IntermediateState state,
    required CrawlerInfo? crawler,
    required FetchNovel fetchNovel,
    required GetNovelByUrl getNovelByUrl,
  })  : _read = read,
        _crawler = crawler,
        _fetchNovel = fetchNovel,
        _getNovelByUrl = getNovelByUrl,
        super(state);

  final Reader _read;
  final CrawlerInfo? _crawler;

  final FetchNovel _fetchNovel;
  final GetNovelByUrl _getNovelByUrl;

  Future<void> fetch() async {
    if (_crawler == null || _crawler!.instance is! ParseNovel) {
      _read(messageServiceProvider).showText('Unable to parse.');
      return;
    }

    if (state.error != null) {
      state = state.copyWith(error: null);
    }

    final failure = (await _fetchNovel.execute(
            _crawler!.instance as ParseNovel, state.novel.url))
        .toNullable();

    // TODO: add error to partial view
    if (failure != null) {
      log.warning(failure);
      _read(messageServiceProvider).showText(failure.message);
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
