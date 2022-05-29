import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import 'provider/crawlers_provider.dart';

List<Widget> buildBrowseHeader(BuildContext context, bool innerBoxIsScrolled) {
  return [
    SliverAppBar(
      title: const Text('Browse'),
      floating: true,
      forceElevated: innerBoxIsScrolled,
    )
  ];
}

class BrowsePage extends ConsumerWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlers = ref.watch(crawlersProvider);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('Browse'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
        )
      ],
      body: CustomScrollView(
        slivers: [
          SliverList(
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
                    dense: true,
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
                  );
                });
              },
              childCount: crawlers.length,
            ),
          )
        ],
      ),
    );
  }
}
