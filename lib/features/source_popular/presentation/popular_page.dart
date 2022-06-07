import 'package:auto_route/auto_route.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/features/browse/browse.dart';
import 'package:nacht/features/source_search/source_search.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import 'provider/popular_fetch_provider.dart';
import 'provider/popular_provider.dart';
import 'provider/popular_view_provider.dart';

class PopularPage extends HookConsumerWidget with LoggerMixin {
  const PopularPage({
    Key? key,
    required this.crawlerFactory,
  }) : super(key: key);

  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawler = ref.watch(crawlerFamily(crawlerFactory));
    final isSearching = ref.watch(isSearchingProvider);

    usePostFrameCallback(
      (timeStamp) {
        ref.watch(popularFetchProvider(crawler).notifier).next();
      },
      condition: crawler.isPopularSupported,
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
              onSubmitted: (text) =>
                  ref.read(searchFetchProvider(crawler).notifier).fetch(text),
            ),
        ],
        body: Consumer(
          builder: (context, ref, child) {
            // prevent auto dispose while this view is active
            ref.watch(popularProvider(crawlerFactory));

            final view = ref.watch(popularViewProvider(crawlerFactory));

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
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
                              .restart();
                        } else {
                          ref
                              .read(popularFetchProvider(crawler).notifier)
                              .restart();
                        }
                      },
                    ),
                  ],
                  empty: () => [],
                  data: (novels) => [
                    SliverFetchGrid(items: novels, crawler: crawler.instance),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final fetch = ref.watch(popularFetchProvider(crawler));

        return AnimatedBottomBar(
          visible: fetch.isLoading,
          child: const PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: LinearProgressIndicator(),
          ),
        );
      }),
    );
  }

  void onScrollEnd(WidgetRef ref, bool isSearching, CrawlerInfo crawler) {
    if (isSearching) {
      final fetch = ref.read(searchFetchProvider(crawler));
      if (fetch.page > 1 && !fetch.isLoading) {
        ref.read(searchFetchProvider(crawler).notifier).next();
      }
    } else {
      final fetch = ref.read(popularFetchProvider(crawler));
      if (fetch.page > 1 && !fetch.isLoading) {
        ref.read(popularFetchProvider(crawler).notifier).next();
      }
    }
  }
}
