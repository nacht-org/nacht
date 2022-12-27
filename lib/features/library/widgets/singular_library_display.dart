import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

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

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (!selection.active)
          SliverAppBar(
            title: const Text('Library'),
            pinned: true,
            forceElevated: innerBoxIsScrolled,
          ),
        if (selection.active)
          SliverSelectionAppBar(
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
          ),
      ],
      body: DestinationTransition(
        child: CategoryGrid(
          category: category,
          pinned: false,
        ),
      ),
    );
  }
}
