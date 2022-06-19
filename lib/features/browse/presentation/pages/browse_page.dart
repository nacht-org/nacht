import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/widgets/widgets.dart';

import '../presentation.dart';

class BrowsePage extends ConsumerWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(browseSearchProvider);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (!search.active)
          SliverAppBar(
            title: const Text('Browse'),
            floating: true,
            forceElevated: innerBoxIsScrolled,
            actions: [
              const BrowseSearchButton(),
              IconButton(
                onPressed: () {
                  showExpandableBottomSheet(
                    context: context,
                    builder: (context, scrollController) => Material(
                      child: BrowseFilterSheet(
                        scrollController: scrollController,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.filter_list),
              ),
            ],
          ),
        if (search.active)
          SliverSearchBar(
            onSubmitted: (text) =>
                ref.read(browseSearchProvider.notifier).search(text),
          )
      ],
      body: DestinationTransition(
        child: CustomScrollView(
          slivers: [
            if (!search.active) const SliverCrawlerList(),
            if (search.active) const SliverSearchResult(),
          ],
        ),
      ),
    );
  }
}
