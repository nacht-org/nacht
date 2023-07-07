import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_hooks/flutter_hooks.dart';

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

    final controller = useScrollController();

    return Scaffold(
      appBar: search.active
          ? SearchBar(
              onSubmitted: (text) =>
                  ref.read(browseSearchProvider.notifier).search(text),
            )
          : AppBar(
              title: const Text('Browse'),
              actions: [
                const BrowseSearchButton(),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (context) {
                        return const BrowseFilterSheet();
                      },
                    );
                  },
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SafeArea(
          child: Scrollbar(
            interactive: true,
            controller: controller,
            child: CustomScrollView(
              controller: controller,
              slivers: [
                if (!search.active) const SliverCrawlerList(),
                if (search.active) const SliverSearchResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
