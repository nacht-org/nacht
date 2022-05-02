import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/providers/providers.dart';
import 'popular_page_loader_state.dart';
import 'popular_page_state.dart';

final crawlerFactoryProvider =
    Provider.autoDispose<CrawlerFactory>((ref) => throw UnimplementedError());

final crawlerMetaProvider = Provider.autoDispose<Meta>(
  (ref) => ref.watch(crawlerFactoryProvider).meta(),
  dependencies: [crawlerFactoryProvider],
);

final crawlerProvider = Provider.autoDispose<Crawler>(
  (ref) => ref.watch(crawlerFactoryProvider).create(),
  dependencies: [crawlerFactoryProvider],
);

final hasPopularFeatureProvider = Provider.autoDispose<bool>(
  (ref) => ref.watch(crawlerMetaProvider).features.contains(Feature.popular),
  dependencies: [crawlerMetaProvider],
);

final popularPageLoaderState = StateNotifierProvider.autoDispose<
    PopularPageLoaderController, PopularPageLoaderState>(
  (ref) {
    return PopularPageLoaderController(
      getPopularNovels: ref.watch(getPopularNovels),
      crawler: ref.watch(crawlerProvider),
      hasPopularFeature: ref.watch(hasPopularFeatureProvider),
    )..loadNext();
  },
  dependencies: [
    getPopularNovels,
    crawlerProvider,
    hasPopularFeatureProvider,
  ],
);

final popularPageState =
    StateNotifierProvider.autoDispose<PopularPageController, PopularPageState>(
  (ref) {
    final initial = ref.watch(hasPopularFeatureProvider)
        ? const PopularPageState.loading()
        : const PopularPageState.unsupported();

    final controller = PopularPageController(initial);

    ref.listen<PopularPageLoaderState>(
      popularPageLoaderState,
      (previous, next) {
        next.whenOrNull(
          data: (novels) => controller.add(novels),
        );
      },
    );

    return controller;
  },
  dependencies: [hasPopularFeatureProvider, popularPageLoaderState],
);
