import 'package:flutter/material.dart' hide SearchBar;

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:nacht/features/browse/main/providers/fetch_local_provider.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../../main/preferences/preferences.dart';

@RoutePage()
class PopularPage extends HookConsumerWidget with LoggerMixin {
  const PopularPage({
    Key? key,
    required this.crawlerFactory,
  }) : super(key: key);

  final sources.CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawler = ref.watch(crawlerFamily(crawlerFactory));
    final isSearching = ref.watch(isSearchingProvider);

    usePostFrameCallback(
      (timeStamp) {
        ref.watch(popularFetchFamily(crawler).notifier).next(crawler);
      },
      condition: crawler.isSupported(sources.Feature.popular),
    );

    return Scaffold(
      appBar: isSearching
          ? SearchBar(
              onSubmitted: (text) => ref
                  .read(searchFetchProvider(crawler).notifier)
                  .fetch(crawler, text),
            )
          : AppBar(
              title: Text(crawler.meta.name),
              actions: [
                const SearchButton(),
                const BrowseDisplayModeMenu(),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () => context.router.push(
                        WebViewRoute(
                          title: crawler.meta.name,
                          initialUrl: crawler.meta.baseUrl,
                        ),
                      ),
                      child: const Text('Open in browser'),
                    ),
                  ],
                ),
              ],
            ),
      body: Consumer(
        builder: (context, ref, child) {
          // prevent auto dispose while this view is active
          ref.watch(popularFamily(crawlerFactory));
          ref.watch(fetchLocalProvider);

          final view = ref.watch(popularViewFamily(crawlerFactory));

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.isAtEnd && view.hasData) {
                log.info('scroll to end notification recieved in popular page');
                onScrollEnd(ref, isSearching, crawler);
              }
              return false;
            },
            child: CustomScrollView(
              slivers: [
                ...view.when(
                  loading: () => [
                    const SliverFillLoadingIndicator(),
                  ],
                  unsupported: (message) => [
                    SliverFillLoadingError(
                      message: Text(message),
                    ),
                  ],
                  error: (message) => [
                    SliverFillLoadingError(
                      message: Text(message),
                      onRetry: () {
                        final isSearching = ref.read(isSearchingProvider);
                        if (isSearching) {
                          ref
                              .read(searchFetchProvider(crawler).notifier)
                              .restart(crawler);
                        } else {
                          ref
                              .read(popularFetchFamily(crawler).notifier)
                              .restart(crawler);
                        }
                      },
                    ),
                  ],
                  empty: () => [],
                  data: (novels) => [
                    SliverFetchDisplay(novels: novels, crawler: crawler),
                  ],
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom + 16.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      extendBody: true,
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final fetch = ref.watch(popularFetchFamily(crawler));

          return ImplicitAnimatedBottomBar(
            visible: !fetch.isInitial && fetch.isLoading,
            child: const SizedBox(
              height: 4.0,
              child: LinearProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  void onScrollEnd(WidgetRef ref, bool isSearching, CrawlerInfo crawler) {
    if (isSearching) {
      final fetch = ref.read(searchFetchProvider(crawler));
      if (fetch.page > 1 && !fetch.isLoading) {
        ref.read(searchFetchProvider(crawler).notifier).next(crawler);
      }
    } else {
      final fetch = ref.read(popularFetchFamily(crawler));
      if (fetch.page > 1 && !fetch.isLoading) {
        ref.read(popularFetchFamily(crawler).notifier).next(crawler);
      }
    }
  }
}

class BrowseDisplayModeMenu extends ConsumerWidget {
  const BrowseDisplayModeMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final selectedDisplayMode = ref.watch(
        browseDisplayPreferencesProvider.select((value) => value.displayMode));
    final notifier = ref.watch(browseDisplayPreferencesProvider.notifier);

    return PopupMenuButton(
      tooltip: "Display mode",
      icon: switch (selectedDisplayMode) {
        BrowseDisplayMode.compactGrid => const Icon(Icons.grid_view),
        BrowseDisplayMode.list => const Icon(Icons.view_list)
      },
      itemBuilder: (context) => List.generate(
        BrowseDisplayMode.values.length,
        (index) {
          final displayMode = BrowseDisplayMode.values[index];

          return PopupMenuItem(
            onTap: () => notifier.setDisplayMode(displayMode),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(displayMode.label),
                ),
                selectedDisplayMode == displayMode
                    ? Icon(
                        Symbols.radio_button_checked,
                        color: theme.colorScheme.primary,
                      )
                    : const Icon(Symbols.radio_button_unchecked),
              ],
            ),
          );
        },
      ),
    );
  }
}
