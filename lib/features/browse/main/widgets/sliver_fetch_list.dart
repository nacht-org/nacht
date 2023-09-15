import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:nacht/features/browse/main/providers/fetch_local_provider.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/core/core.dart';
import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

class SliverFetchList extends StatelessWidget {
  const SliverFetchList({
    Key? key,
    required this.novels,
    required this.crawler,
  }) : super(key: key);

  final List<PartialNovelData> novels;
  final CrawlerInfo crawler;

  @override
  Widget build(BuildContext context) {
    return SliverList(
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

              return MuteTile(
                muted: favourite,
                child: ListTile(
                  leading: NovelAvatar(
                    novel: NovelType.partial(novel),
                    desaturate: favourite,
                  ),
                  title: Text(
                    novel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => context.router.push(NovelRoute(
                    type: NovelType.partial(novel),
                  )),
                  trailing:
                      favourite ? const Icon(Symbols.favorite, fill: 1) : null,
                ),
              );
            },
          );
        },
        childCount: novels.length,
      ),
    );
  }
}
