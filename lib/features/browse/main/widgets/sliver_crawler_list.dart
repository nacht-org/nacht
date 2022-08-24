import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../main.dart';

class SliverCrawlerList extends ConsumerWidget {
  const SliverCrawlerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlers = ref.watch(crawlersProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return crawlers[index].when(language: (language) {
            final lang =
                langFromCode(language)?['name'] ?? language.capitalize();

            return ListTile(
              title: Text(
                lang,
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }, crawler: (entry) {
            final lang = langFromCode(entry.meta.lang)?['name'] ??
                entry.meta.lang.capitalize();

            return ListTile(
              title: Text(entry.meta.name),
              subtitle: Text('$lang ${entry.meta.version.version}'),
              onTap: () => context.router.push(
                PopularRoute(crawlerFactory: entry.factory),
              ),
              enabled: entry.isSupported,
            );
          });
        },
        childCount: crawlers.length,
      ),
    );
  }
}
