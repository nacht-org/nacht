import 'package:auto_route/auto_route.dart';
import 'package:nacht/components/browse/widgets/sliver_fetch_grid.dart';
import 'package:nacht/components/components.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/provider/provider.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../search/search.dart';
import 'provider/popular_fetch_provider.dart';
import 'provider/popular_provider.dart';
import 'provider/popular_view_provider.dart';

class PopularPage extends HookConsumerWidget {
  const PopularPage({
    Key? key,
    required this.crawlerFactory,
  }) : super(key: key);

  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawler = ref.watch(crawlerProvider(crawlerFactory));
    final isSearching = ref.watch(isSearchingProvider);

    usePostFrameCallback(
      (timeStamp) {
        ref.watch(popularFetchProvider(crawler).notifier).fetch();
      },
      condition: crawler.popularSupported,
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
            SearchBar(
              onSubmitted: (text) =>
                  ref.read(searchFetchProvider(crawler).notifier).fetch(text),
            ),
        ],
        body: Consumer(
          builder: (context, ref, child) {
            // prevent auto dispose while this view is active
            ref.watch(popularProvider(crawlerFactory));

            final view = ref.watch(popularViewProvider(crawlerFactory));

            return CustomScrollView(
              slivers: view.when(
                loading: () => [
                  const SliverFillLoadingIndicator(),
                ],
                unsupported: (message) => [
                  SliverFillLoadingError(
                    message: Text(message),
                  ),
                ],
                empty: () => [],
                data: (novels) => [
                  SliverFetchGrid(items: novels, crawler: crawler.instance),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 64,
                      alignment: Alignment.center,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final fetch =
                              ref.watch(popularFetchProvider(crawler));
                          final notifier =
                              ref.watch(popularFetchProvider(crawler).notifier);

                          if (fetch.isLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return TextButton(
                              onPressed: notifier.fetch,
                              child: const Text('Load more'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
