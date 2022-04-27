import 'package:auto_route/auto_route.dart';
import 'package:chapturn/config/routes/app_router.dart';
import 'package:chapturn/presentation/widgets/searchable_scroll_view.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../novel_page/data/novel_page_args.dart';
import 'controllers/popular_page.dart';
import '../../widgets/novel_grid_card.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({Key? key, required this.crawlerFactory}) : super(key: key);

  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        crawlerFactoryProvider.overrideWithValue(crawlerFactory),
      ],
      child: const Scaffold(
        body: PopularView(),
      ),
    );
  }
}

final isSearchEnabled = StateProvider((ref) => false);

final searchTextProvider = StateProvider((ref) => '');

class PopularView extends SearchableScrollView {
  const PopularView({Key? key}) : super(key: key);

  @override
  StateProvider<bool> get isSearching => isSearchEnabled;

  @override
  StateProvider<String> get searchtext => searchTextProvider;

  @override
  Widget buildAppBar(
      BuildContext context, bool innerBoxIsScrolled, WidgetRef ref) {
    final meta = ref.watch(crawlerMetaProvider);

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
    final pageState = ref.watch(popularPageState);
    final crawler = ref.watch(crawlerProvider);

    return pageState.when(
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
                  novel: NovelEntityArgument.partial(novel),
                  crawler: crawler,
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
            child: Consumer(builder: (context, ref, child) {
              final loaderState = ref.watch(popularPageLoaderState);

              return loaderState.when(
                data: (_) {
                  return TextButton(
                    child: const Text('Load more'),
                    onPressed: () =>
                        ref.read(popularPageLoaderState.notifier).loadNext(),
                  );
                },
                loading: () => const CircularProgressIndicator(),
              );
            }),
          ),
        ),
      ],
    );
  }
}
