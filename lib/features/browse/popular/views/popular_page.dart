import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../../browse.dart';

class PopularPage extends HookConsumerWidget with LoggerMixin {
  const PopularPage({
    Key? key,
    required this.crawlerFactory,
  }) : super(key: key);

  final sources.CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawler = ref.watch(crawlerFamily(crawlerFactory));
    final isSearching = ref.watch(isSearchingProvider);

    usePostFrameCallback(
      (timeStamp) {
        ref.watch(popularFetchFamily(crawler).notifier).next(crawler);
      },
      condition: crawler.isSupported(sources.Feature.popular),
    );

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          if (!isSearching)
            SliverAppBar(
              title: Text(crawler.meta.name),
              actions: [
                const SearchButton(),
                IconButton(
                  icon: const Icon(Icons.web),
                  onPressed: () => context.router.push(WebViewRoute(
                    title: crawler.meta.name,
                    initialUrl: crawler.meta.baseUrl,
                  )),
                ),
              ],
            ),
          if (isSearching)
            SliverSearchBar(
              onSubmitted: (text) => ref
                  .read(searchFetchProvider(crawler).notifier)
                  .fetch(crawler, text),
            ),
        ],
        body: Consumer(
          builder: (context, ref, child) {
            // prevent auto dispose while this view is active
            ref.watch(popularFamily(crawlerFactory));

            final view = ref.watch(popularViewFamily(crawlerFactory));

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.isAtEnd) {
                  log.info(
                      'scroll to end notification recieved in popular page');
                  onScrollEnd(ref, isSearching, crawler);
                }
                return false;
              },
              child: CustomScrollView(
                slivers: view.when(
                  loading: () => [
                    const SliverFillLoadingIndicator(),
                  ],
                  unsupported: (message) => [
                    SliverFillLoadingError(
                      message: Text(message),
                    ),
                  ],
                  error: (message) => [
                    SliverFillLoadingError(
                      message: Text(message),
                      onRetry: () {
                        final isSearching = ref.read(isSearchingProvider);
                        if (isSearching) {
                          ref
                              .read(searchFetchProvider(crawler).notifier)
                              .restart(crawler);
                        } else {
                          ref
                              .read(popularFetchFamily(crawler).notifier)
                              .restart(crawler);
                        }
                      },
                    ),
                  ],
                  empty: () => [],
                  data: (novels) => [
                    SliverFetchGrid(items: novels, crawler: crawler),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final fetch = ref.watch(popularFetchFamily(crawler));

          return AnimatedBottomBar(
            visible: !fetch.isInitial && fetch.isLoading,
            child: const SizedBox(
              height: 4.0,
              child: LinearProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  void onScrollEnd(WidgetRef ref, bool isSearching, CrawlerInfo crawler) {
    if (isSearching) {
      final fetch = ref.read(searchFetchProvider(crawler));
      if (fetch.page > 1 && !fetch.isLoading) {
        ref.read(searchFetchProvider(crawler).notifier).next(crawler);
      }
    } else {
      final fetch = ref.read(popularFetchFamily(crawler));
      if (fetch.page > 1 && !fetch.isLoading) {
        ref.read(popularFetchFamily(crawler).notifier).next(crawler);
      }
    }
  }
}
