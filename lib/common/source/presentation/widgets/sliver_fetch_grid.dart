import 'package:auto_route/auto_route.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SliverFetchGrid extends StatelessWidget {
  const SliverFetchGrid({
    Key? key,
    required this.items,
    required this.crawler,
  }) : super(key: key);

  final List<PartialNovelData> items;
  final CrawlerInfo crawler;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = items[index];
            return NovelGridCard(
              title: item.title,
              coverUrl: item.coverUrl,
              onTap: () => context.router.push(NovelRoute(
                type: NovelType.partial(item),
              )),
            );
          },
          childCount: items.length,
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
