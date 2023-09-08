import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class HistoryBody extends HookConsumerWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final isEmpty = ref.watch(historyProvider.select((value) => value.isEmpty));

    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Scrollbar(
        interactive: true,
        controller: controller,
        child: isEmpty
            ? const CenterChildScrollView(
                child: EmptyIndicator(
                  icon: Icon(Icons.history),
                  label: Text('No history'),
                ),
              )
            : Consumer(
                builder: (context, ref, child) {
                  final entries = ref.watch(historyEntriesProvider);

                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];

                      return entry.when(
                        date: (date) => RelativeDateTile(date: date),
                        history: (history) => HistoryTile(history: history),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
