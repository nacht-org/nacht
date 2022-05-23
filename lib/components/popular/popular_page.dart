import 'package:auto_route/auto_route.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';
import '../components.dart';
import '../widgets/novel_grid_card.dart';
import 'provider/crawler_info_provider.dart';
import 'provider/popular_fetch_provider.dart';
import 'provider/popular_provider.dart';

class PopularPage extends HookConsumerWidget {
  const PopularPage({
    Key? key,
    required this.crawlerFactory,
  }) : super(key: key);

  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(crawlerInfoProvider(crawlerFactory));

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.watch(popularFetchProvider(info).notifier).fetch();
      });

      return null;
    }, []);

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(info.meta.name),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          )
        ],
        body: Consumer(
          builder: (context, ref, child) {
            final view = ref.watch(popularProvider(crawlerFactory));

            return CustomScrollView(
              slivers: view.when(
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
                      child: Text(
                          'This source has no support to fetch popular novels.'),
                    ),
                    hasScrollBody: false,
                  ),
                ],
                data: (novels) => [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final novel = novels[index];
                          return NovelGridCard(
                            title: novel.title,
                            coverUrl: novel.coverUrl,
                            onTap: () => context.router.push(NovelRoute(
                              either: NovelEither.partial(novel, info.crawler),
                            )),
                          );
                        },
                        childCount: novels.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 2 / 3,
                      ),
                    ),
                  ),
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
