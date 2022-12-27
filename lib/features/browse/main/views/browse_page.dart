import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/widgets/widgets.dart';

class BrowsePage extends HookConsumerWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(browseSearchProvider);

    // Hide bottom navigation bar when searching.
    NavigationNotifier.handleHide(
      ref,
      browseSearchProvider.select((search) => search.active),
    );

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (!search.active)
          SliverAppBar(
            title: const Text('Browse'),
            pinned: true,
            forceElevated: innerBoxIsScrolled,
            actions: [
              const BrowseSearchButton(),
              IconButton(
                onPressed: () {
                  showExpandableBottomSheet(
                    context: context,
                    builder: (context, scrollController) {
                      return BrowseFilterSheet(
                        scrollController: scrollController,
                      );
                    },
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
