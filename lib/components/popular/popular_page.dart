import 'package:chapturn/components/browse/widgets/sliver_fetch_grid.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extrinsic/core/core.dart';
import '../../provider/provider.dart';
import '../components.dart';
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
    final info = ref.watch(crawlerProvider(crawlerFactory));
    final isSearching = ref.watch(isSearchingProvider);

    usePostFrameCallback(
      (timeStamp) {
        ref.watch(popularFetchProvider(info).notifier).fetch();
      },
      condition: info.popularSupported,
    );

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          if (!isSearching)
            SliverAppBar(
              title: Text(info.meta.name),
              actions: const [SearchButton()],
            ),
          if (isSearching)
            SearchBar(
              onSubmitted: (text) =>
                  ref.read(searchFetchProvider(info).notifier).fetch(),
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
                  SliverFetchGrid(items: novels, crawler: info.crawler),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 64,
                      alignment: Alignment.center,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final fetch = ref.watch(popularFetchProvider(info));
                          final notifier =
                              ref.watch(popularFetchProvider(info).notifier);

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
