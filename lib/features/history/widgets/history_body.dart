import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class HistoryBody extends HookConsumerWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final isEmpty = ref.watch(historyProvider.select((value) => value.isEmpty));

    return Scrollbar(
      interactive: true,
      controller: controller,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          if (!isEmpty)
            Consumer(
              builder: (context, ref, child) {
                final entries = ref.watch(historyEntriesProvider);

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final entry = entries[index];

                      return entry.when(
                        date: (date) => RelativeDateTile(date: date),
                        history: (history) => HistoryTile(history: history),
                      );
                    },
                    childCount: entries.length,
                  ),
                );
              },
            ),
          if (isEmpty)
            const SliverFillEmptyIndicator(
              icon: Icon(Icons.history),
              label: Text('No history'),
            ),
          const SliverToBoxAdapter(
            child: NavigationOffset(),
          ),
        ],
      ),
    );
  }
}
