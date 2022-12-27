import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/features/updates/providers/providers.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../widgets/widgets.dart';

class UpdatesPage extends HookConsumerWidget {
  const UpdatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionActive = ref.watch(
      updatesSelectionProvider.select((selection) => selection.active),
    );

    // FIXME: selection gets set to active after exiting by deselecting all.
    SelectionNotifier.handleRoute(context, ref, updatesSelectionProvider);

    // Hide bottom navigation bar when selecting.
    // FIXME: only depend on selection active status. the current is a workaround
    // due to above issue.
    NavigationNotifier.handleHide(
      ref,
      updatesSelectionProvider.select(
        (selection) => selection.active && selection.selected.isNotEmpty,
      ),
    );

    return Scaffold(
      body: const UpdatesView(),
      bottomNavigationBar: ImplicitAnimatedBottomBar(
        visible: selectionActive,
        child: CustomBottomBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                tooltip: "Mark as read",
                onPressed: () {
                  final selected = ref.read(updatesSelectionProvider).selected;
                  ref.read(setReadAtProvider).execute(selected, true);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.check),
              ),
              IconButton(
                tooltip: "Mark as unread",
                onPressed: () {
                  final selected = ref.read(updatesSelectionProvider).selected;
                  ref.read(setReadAtProvider).execute(selected, false);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdatesView extends HookConsumerWidget {
  const UpdatesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshIndicatorKey = useMemoized(
      () => GlobalKey<RefreshIndicatorState>(),
    );

    final selectionActive = ref.watch(
      updatesSelectionProvider.select((selection) => selection.active),
    );

    final refreshNotifier = ref.watch(refreshProvider.notifier);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (!selectionActive)
          SliverAppBar(
            title: const Text('Updates'),
            pinned: true,
            forceElevated: innerBoxIsScrolled,
            actions: [
              Consumer(
                builder: (context, ref, child) {
                  final isBusy = ref.watch(refreshProvider);

                  return IconButton(
                    tooltip: "Refresh",
                    onPressed: isBusy
                        ? null
                        : () => refreshIndicatorKey.currentState!.show(),
                    icon: const Icon(Icons.refresh),
                  );
                },
              ),
            ],
          ),
        if (selectionActive) const UpdatesSelectionAppBar(),
      ],
      body: DestinationTransition(
        child: RefreshIndicator(
          onRefresh: refreshNotifier.refreshAll,
          child: Scrollbar(
            child: Consumer(
              builder: (context, ref, child) {
                final updatesEmpty =
                    ref.watch(updatesProvider.select((value) => value.isEmpty));

                return CustomScrollView(
                  slivers: [
                    if (!updatesEmpty)
                      Consumer(
                        builder: (context, ref, child) {
                          final updates = ref.watch(updatesProvider);

                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => updates[index].when(
                                date: (date) => RelativeDateTile(date: date),
                                chapter: (novel, chapter) => ChapterUpdateTile(
                                  novel: novel,
                                  chapter: chapter,
                                ),
                              ),
                              childCount: updates.length,
                            ),
                          );
                        },
                      ),
                    if (updatesEmpty)
                      const SliverFillEmptyIndicator(
                        child: Icon(Icons.update),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
