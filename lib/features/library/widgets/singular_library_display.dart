import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/features/library/providers/library_selection_provider.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import 'widgets.dart';

class SingularLibraryDisplay extends HookConsumerWidget {
  const SingularLibraryDisplay({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryData category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.watch(navigationProvider.notifier);
    final controller = useNavigationScrollController(navigationNotifier);

    final selection = ref.watch(librarySelectionProvider);

    return NestedScrollView(
      controller: controller,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        if (!selection.active)
          SliverAppBar(
            title: const Text('Library'),
            floating: true,
            forceElevated: innerBoxIsScrolled,
          ),
        if (selection.active)
          SliverSelectionAppBar(title: Text("${selection.selected.length}")),
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
