import 'package:chapturn/domain/entities/partial_novel_entity.dart';
import 'package:chapturn/presentation/controllers/popular_page/popular_page.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        body: PopularPageView(),
      ),
    );
  }
}

class PopularPageView extends ConsumerWidget {
  const PopularPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meta = ref.watch(crawlerMetaProvider);
    final novels = ref.watch(popularPageState);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(meta.name),
          floating: true,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final novel = novels[index];
              return PopularNovelCard(novel: novel);
            },
            childCount: novels.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
        ),
        SliverFillRemaining(
          child: Center(
            child: Consumer(builder: (context, ref, child) {
              final loaderState = ref.watch(popularPageLoaderState);

              return loaderState.when(
                data: (_) {
                  return TextButton(
                    child: const Text('Load more'),
                    onPressed: () {},
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

class PopularNovelCard extends StatelessWidget {
  const PopularNovelCard({
    Key? key,
    required this.novel,
  }) : super(key: key);

  final PartialNovelEntity novel;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            if (novel.thumbnailUrl != null)
              SizedBox.expand(
                child: Ink.image(
                  image: NetworkImage(novel.thumbnailUrl!),
                  fit: BoxFit.fill,
                ),
              ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withAlpha(200),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  novel.title,
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              bottom: 0,
              left: 0,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}
