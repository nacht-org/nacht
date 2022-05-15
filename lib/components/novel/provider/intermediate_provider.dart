import 'package:chapturn/core/services/message_service.dart';
import 'package:chapturn/domain/services/novel_service.dart';
import 'package:chapturn/domain/services/source_service.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/novel/novel_data.dart';
import '../../../domain/entities/novel/partial_novel_data.dart';
import '../model/novel_either.dart';

part 'intermediate_provider.freezed.dart';

final intermediateProvider = StateNotifierProvider.autoDispose
    .family<IntermediateNotifier, IntermediateState, NovelEither>(
  (ref, either) {
    final sourceService = ref.watch(sourceServiceProvider);

    final url = either.when(
      partial: (novel, crawler) => novel.url,
      complete: (novel) => novel.url,
    );

    final crawlerFactory =
        sourceService.crawlerFactoryFor(url: url).toNullable();

    final state = either.when(
      partial: (novel, crawler) =>
          IntermediateState.partial(novel, crawlerFactory?.meta(), crawler),
      complete: (novel) => IntermediateState.complete(
          novel, crawlerFactory?.meta(), crawlerFactory?.basic()),
    );

    final crawler = either.when(
      partial: (novel, crawler) => crawler,
      complete: (novel) => null,
    );

    return IntermediateNotifier(
      state: state,
      crawler: crawler,
      read: ref.read,
      novelService: ref.watch(novelServiceProvider),
    );
  },
);

@freezed
class IntermediateState with _$IntermediateState {
  factory IntermediateState.partial(
    PartialNovelData novel,
    Meta? meta,
    Crawler? crawler,
  ) = _PartialIntermediate;

  factory IntermediateState.complete(
    NovelData novel,
    Meta? meta,
    Crawler? crawler,
  ) = _CompleteIntermediate;
}

class IntermediateNotifier extends StateNotifier<IntermediateState>
    with LoggerMixin {
  IntermediateNotifier({
    required IntermediateState state,
    required this.crawler,
    required this.read,
    required this.novelService,
  }) : super(state);

  final Crawler? crawler;
  final Reader read;

  final NovelService novelService;

  Future<void> reload() async {
    final url = state.map(
      partial: (state) => state.novel.url,
      complete: (state) => state.novel.url,
    );

    if (crawler == null || crawler is! ParseNovel) {
      read(messageServiceProvider).showText('Unable to parse.');
      return;
    }

    log.info('Start parse or get novel.');
    final result = await novelService.parseOrGet(crawler as ParseNovel, url);
    log.info('End parse or get novel.');

    result.fold(
      (failure) => read(messageServiceProvider).showText('An error occured'),
      (data) async {
        state = IntermediateState.complete(data, state.meta, state.crawler);

        log.info('Downloading cover.');
        final coverResult = await novelService.downloadCover(data);
        coverResult.fold(
          (failure) => {},
          (cover) => state = IntermediateState.complete(
            data.copyWith(cover: cover),
            state.meta,
            state.crawler,
          ),
        );
      },
    );
  }
}
