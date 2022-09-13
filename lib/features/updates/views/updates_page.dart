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

    final navigationNotifier = ref.watch(navigationProvider.notifier);
    final controller = useNavigationScrollController(navigationNotifier);

    final selectionActive = ref.watch(
      updatesSelectionProvider.select((selection) => selection.active),
    );

    return NestedScrollView(
      controller: controller,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (!selectionActive)
          SliverAppBar(
            title: const Text('Updates'),
            floating: true,
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
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: DestinationTransition(
          child: Consumer(
            builder: (context, ref, child) {
              final updates = ref.watch(updatesProvider);
              final refreshNotifier = ref.watch(refreshProvider.notifier);

              return RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: refreshNotifier.refreshAll,
                notificationPredicate:
                    selectionActive ? (_) => false : (_) => true,
                child: Scrollbar(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) => updates[index].when(
                      date: (date) => DateUpdateTile(date: date),
                      chapter: (novel, chapter) => ChapterUpdateTile(
                        novel: novel,
                        chapter: chapter,
                      ),
                    ),
                    itemCount: updates.length,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
