import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/browse/main/providers/fetch_local_provider.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SliverFetchGrid extends ConsumerWidget {
  const SliverFetchGrid({
    Key? key,
    required this.novels,
    required this.crawler,
  }) : super(key: key);

  final List<PartialNovelData> novels;
  final CrawlerInfo crawler;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridSize = ref
        .watch(novelGridPreferencesProvider.select((value) => value.gridSize));

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final novel = novels[index];

            return HookConsumer(
              builder: (context, ref, child) {
                final notifier = ref.watch(fetchLocalProvider.notifier);
                final favourite = ref.watch(
                  fetchLocalProvider
                      .select((map) => map[novel.url]?.favourite ?? false),
                );

                usePostFrameCallback((timeStamp) {
                  notifier.load(novel.url);
                });

                return NovelGridCard(
                  title: novel.title,
                  coverUrl: novel.coverUrl,
                  onTap: () => context.router.push(NovelRoute(
                    type: NovelType.partial(novel),
                  )),
                  favourite: favourite,
                );
              },
            );
          },
          childCount: novels.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridSize ?? 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 2 / 3,
        ),
      ),
    );
  }
}
