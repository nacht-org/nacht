import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../widgets/widgets.dart';
import '../providers/providers.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionActive = ref.watch(
      historySelectionProvider.select((selection) => selection.active),
    );

    SelectionNotifier.handleRoute(context, ref, historySelectionProvider);
    NavigationNotifier.handleHide(
      ref,
      historySelectionProvider.select(
        (value) => value.active && value.selected.isNotEmpty,
      ),
    );

    final notifier = ref.watch(historyProvider.notifier);

    return Scaffold(
      body: const HistoryBody(),
      bottomNavigationBar: ImplicitAnimatedBottomBar(
        visible: selectionActive,
        child: CustomBottomBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                tooltip: "Delete history",
                onPressed: () {
                  notifier.deleteHistory();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                tooltip: "Delete novel history",
                onPressed: () {
                  notifier.deleteNovelHistory();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete_sweep),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
