import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/browse/main/providers/fetch_local_provider.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class SliverFetchGrid extends StatelessWidget {
  const SliverFetchGrid({
    Key? key,
    required this.novels,
    required this.crawler,
  }) : super(key: key);

  final List<PartialNovelData> novels;
  final CrawlerInfo crawler;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final novel = novels[index];

            return HookConsumer(
              builder: (context, ref, child) {
                final notifier = ref.watch(fetchLocalProvider.notifier);
                final favorite = ref.watch(
                  fetchLocalProvider
                      .select((map) => FetchLocalInfo.favorite(map[novel.url])),
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
                  favorite: favorite,
                );
              },
            );
          },
          childCount: novels.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 2 / 3,
        ),
      ),
    );
  }
}
