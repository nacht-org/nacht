import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class SingularLibraryDisplay extends HookConsumerWidget {
  const SingularLibraryDisplay({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryData category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(librarySelectionProvider);
    final selectionNotifier = ref.watch(librarySelectionProvider.notifier);

    return Scaffold(
      appBar: selection.active
          ? SelectionAppBar(
              title: Text("${selection.selected.length}"),
              onSelectAllPressed: () async {
                final novels =
                    await ref.read(categoryNovelsFamily(category.id).future);
                selectionNotifier.addAll(novels.map((novel) => novel.id));
              },
              onInversePressed: () async {
                final novels =
                    await ref.read(categoryNovelsFamily(category.id).future);
                selectionNotifier.flipAll(novels.map((novel) => novel.id));
              },
            )
          : AppBar(
              title: const Text('Library'),
              actions: [
                IconButton(
                  onPressed: () => LibrarySheet.show(context),
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
      body: SafeArea(
        child: CategoryDisplay(
          category: category,
        ),
      ),
      extendBody: true,
    );
  }
}
