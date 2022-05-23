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
    final crawlerFactories = ref.watch(crawlersProvider);

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
                final meta = crawlerFactories[index].meta();
                final lang =
                    langFromCode(meta.lang)?['name'] ?? meta.lang.capitalize();

                return ListTile(
                  title: Text(meta.name),
                  subtitle: Text('$lang ${meta.version.version}'),
                  trailing: TextButton(
                    child: const Text('Latest'),
                    onPressed: () {},
                  ),
                  onTap: () => context.router.push(
                    PopularRoute(crawlerFactory: crawlerFactories[index]),
                  ),
                );
              },
              childCount: crawlerFactories.length,
            ),
          )
        ],
      ),
    );
  }
}
