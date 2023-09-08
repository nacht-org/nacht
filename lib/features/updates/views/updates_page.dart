import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/features/updates/models/models.dart';
import 'package:nacht/features/updates/providers/providers.dart';
import 'package:nacht/widgets/widgets.dart';

import '../widgets/widgets.dart';

class UpdatesPage extends HookConsumerWidget {
  const UpdatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshKey = useMemoized(() => GlobalKey<RefreshIndicatorState>());

    final selection = ref.watch(updatesSelectionProvider);
    final selectionNotifier = ref.watch(updatesSelectionProvider.notifier);

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

    Iterable<int> getIds() {
      return ref
          .read(updatesProvider)
          .map((entry) =>
              entry.whenOrNull(chapter: (novel, chapter) => chapter.id))
          .whereType<int>();
    }

    return Scaffold(
      appBar: selectionActive
          ? SelectionAppBar(
              title: Text("${selection.selected.length}"),
              onSelectAllPressed: () => selectionNotifier.addAll(getIds()),
              onInversePressed: () => selectionNotifier.flipAll(getIds()),
            )
          : AppBar(
              title: const Text('Updates'),
              actions: [
                Consumer(
                  builder: (context, ref, child) {
                    final isBusy = ref.watch(refreshProvider);

                    return IconButton(
                      tooltip: "Refresh",
                      onPressed:
                          isBusy ? null : () => refreshKey.currentState!.show(),
                      icon: const Icon(Icons.refresh),
                    );
                  },
                ),
              ],
            ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: UpdatesView(
          refreshKey: refreshKey,
        ),
      ),
      extendBody: true,
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
              IconButton(
                tooltip: "Download",
                onPressed: () {
                  final selection = ref.read(updatesSelectionProvider);
                  final updates = ref.read(updatesProvider);
                  final chaptersToDownload = updates
                      .whereType<UpdateEntryChapter>()
                      .where((entry) =>
                          entry.pair.content == null &&
                          selection.contains(entry.pair.id))
                      .map((entry) =>
                          DownloadRelatedData.from(entry.novel, entry.pair));

                  ref
                      .read(downloadListProvider.notifier)
                      .addMany(chaptersToDownload);
                  context.router.pop();
                },
                icon: const Icon(Icons.download),
              ),
              IconButton(
                tooltip: "Delete",
                onPressed: () {
                  final selection = ref.read(updatesSelectionProvider);
                  final updates = ref.read(updatesProvider);
                  final chaptersToDelete = updates
                      .map((entry) => entry.whenOrNull(
                          chapter: (novel, chapter) => chapter))
                      .whereType<ChapterData>()
                      .where((chapter) =>
                          chapter.content != null &&
                          selection.contains(chapter.id));

                  ref
                      .read(deleteManyDownloadedChaptersProvider)
                      .call(chaptersToDelete);
                  context.router.pop();
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdatesView extends HookConsumerWidget {
  const UpdatesView({
    Key? key,
    required this.refreshKey,
  }) : super(key: key);

  final GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final refreshNotifier = ref.watch(refreshProvider.notifier);

    final selectionActive = ref.watch(
      updatesSelectionProvider.select((selection) => selection.active),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshNotifier.refreshAll,
          notificationPredicate: selectionActive
              ? (_) => false
              : defaultScrollNotificationPredicate,
          child: Scrollbar(
            interactive: true,
            controller: controller,
            child: Consumer(
              builder: (context, ref, child) {
                final updatesEmpty =
                    ref.watch(updatesProvider.select((value) => value.isEmpty));

                if (updatesEmpty) {
                  return const CenterChildScrollView(
                    child: EmptyIndicator(
                      icon: Icon(Icons.update),
                      label: Text('No updates'),
                    ),
                  );
                }

                return Consumer(
                  builder: (context, ref, child) {
                    final updates = ref.watch(updatesProvider);

                    return ListView.builder(
                      controller: controller,
                      itemCount: updates.length,
                      itemBuilder: (context, index) => updates[index].when(
                        date: (date) => RelativeDateTile(date: date),
                        chapter: (novel, chapter) => ChapterUpdateTile(
                          novel: novel,
                          chapter: chapter,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
