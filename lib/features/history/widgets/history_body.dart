import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class HistoryBody extends HookConsumerWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.watch(navigationProvider.notifier);
    final controller = useNavigationScrollController(navigationNotifier);

    final entries = ref.watch(historyEntriesProvider);

    final selectionActive = ref.watch(
        historySelectionProvider.select((selection) => selection.active));
    final selectionCount = ref.watch(historySelectionProvider
        .select((selection) => selection.selected.length));
    final selectionNotifier = ref.watch(historySelectionProvider.notifier);

    List<int> getIds() {
      return ref.read(historyProvider).map((history) => history.id).toList();
    }

    return NestedScrollView(
      controller: controller,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (!selectionActive)
          SliverAppBar(
            title: const Text("History"),
            floating: true,
            forceElevated: innerBoxIsScrolled,
          ),
        if (selectionActive)
          SliverSelectionAppBar(
            title: Text("$selectionCount"),
            onSelectAllPressed: () => selectionNotifier.addAll(getIds()),
            onInversePressed: () => selectionNotifier.flipAll(getIds()),
          )
      ],
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemBuilder: (context, index) {
            final entry = entries[index];

            return entry.when(
              date: (date) => RelativeDateTile(date: date),
              history: (history) => HistoryTile(history: history),
            );
          },
          itemCount: entries.length,
        ),
      ),
    );
  }
}
