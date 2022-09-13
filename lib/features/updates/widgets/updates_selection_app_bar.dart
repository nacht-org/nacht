import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../providers/providers.dart';

class UpdatesSelectionAppBar extends ConsumerWidget {
  const UpdatesSelectionAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(updatesSelectionProvider);
    final selectionNotifier = ref.watch(updatesSelectionProvider.notifier);

    Iterable<int> getIds() {
      return ref
          .read(updatesProvider)
          .map((entry) =>
              entry.whenOrNull(chapter: (novel, chapter) => chapter.id))
          .whereType<int>();
    }

    return SliverSelectionAppBar(
      title: Text("${selection.selected.length}"),
      onSelectAllPressed: () => selectionNotifier.addAll(getIds()),
      onInversePressed: () => selectionNotifier.flipAll(getIds()),
    );
  }
}
