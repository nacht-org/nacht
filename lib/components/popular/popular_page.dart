import 'package:auto_route/auto_route.dart';
import 'package:chapturn/components/popular/provider/crawler_info_provider.dart';
import 'package:chapturn/components/popular/provider/popular_fetch_provider.dart';
import 'package:chapturn/components/popular/provider/popular_provider.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';
import '../novel/model/novel_either.dart';
import '../widgets/novel_grid_card.dart';
import '../widgets/searchable_scroll_view.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({Key? key, required this.crawlerFactory}) : super(key: key);

  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context) {
    return PopularView(
      crawlerFactory: crawlerFactory,
    );
  }
}

final isSearchEnabled = StateProvider((ref) => false);

final searchTextProvider = StateProvider((ref) => '');

class PopularView extends SearchableScrollView {
  const PopularView({
    Key? key,
    required this.crawlerFactory,
  }) : super(key: key);

  final CrawlerFactory crawlerFactory;

  @override
  StateProvider<bool> get isSearching => isSearchEnabled;

  @override
  StateProvider<String> get searchtext => searchTextProvider;

  @override
  Widget buildAppBar(
      BuildContext context, bool innerBoxIsScrolled, WidgetRef ref) {
    final meta = ref.watch(
      crawlerInfoProvider(crawlerFactory).select((info) => info.meta),
    );

    return SliverAppBar(
      title: Text(meta.name),
      actions: [
        getSearchAction(context, ref),
      ],
      floating: true,
      forceElevated: innerBoxIsScrolled,
    );
  }

  @override
  Widget buildSearchBar(
    BuildContext context,
    bool innerBoxIsScrolled,
    WidgetRef ref,
    TextEditingController controller,
  ) {
    return buildDefaultSearchBar(
      context,
      innerBoxIsScrolled,
      ref,
      controller: controller,
      onEditingComplete: () => print('search'),
    );
  }

  @override
  List<Widget> buildBody(BuildContext context, WidgetRef ref) {
    final popularState = ref.watch(popularProvider(crawlerFactory));

    return popularState.when(
      loading: () => [
        const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
          hasScrollBody: false,
        ),
      ],
      unsupported: () => [
        const SliverFillRemaining(
          child: Center(
            child: Text('This source has no support to fetch popular novels.'),
          ),
          hasScrollBody: false,
        ),
      ],
      data: (novels) => [
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final novel = novels[index];
              return NovelGridCard(
                title: novel.title,
                coverUrl: novel.coverUrl,
                onTap: () => context.router.push(NovelRoute(
                  novel: NovelEither.partial(novel),
                  crawler: null, // TODO: Pass along crawler
                )),
              );
            },
            childCount: novels.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 64,
            alignment: Alignment.center,
            child: Consumer(
              builder: (context, ref, child) {
                final info = ref.watch(crawlerInfoProvider(crawlerFactory));
                final fetch = ref.watch(popularFetchProvider(info));
                final notifier = ref.watch(popularFetchProvider(info).notifier);

                if (fetch.isLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return TextButton(
                    child: const Text('Load more'),
                    onPressed: notifier.fetch,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
