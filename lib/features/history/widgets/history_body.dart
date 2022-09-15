import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/features/history/providers/history_selection_provider.dart';
import 'package:nacht/features/history/widgets/widgets.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';

class HistoryBody extends HookConsumerWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.watch(navigationProvider.notifier);
    final controller = useNavigationScrollController(navigationNotifier);

    final entriesValue = ref.watch(historyEntriesProvider);

    final selectionActive = ref.watch(
        historySelectionProvider.select((selection) => selection.active));
    final selectionCount = ref.watch(historySelectionProvider
        .select((selection) => selection.selected.length));
    final selectionNotifier = ref.watch(historySelectionProvider.notifier);

    List<int> getIds() {
      final data = ref.read(historyProvider).value;
      if (data == null) {
        return [];
      }

      return data.map((history) => history.id).toList();
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
      body: entriesValue.when(
        data: (entries) => MediaQuery.removePadding(
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
        error: (error, stack) => LoadingError(
          message: Text(error.toString()),
        ),
        loading: () => const SizedBox.shrink(),
      ),
    );
  }
}
