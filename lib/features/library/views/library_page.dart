import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LibraryPage extends HookConsumerWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(libraryViewProvider);

    final selectionActive = ref.watch(
      librarySelectionProvider.select((selection) => selection.active),
    );

    SelectionNotifier.handleRoute(context, ref, librarySelectionProvider);

    // Hide bottom navigation bar when selecting.
    NavigationNotifier.handleHide(
      ref,
      librarySelectionProvider.select((value) => value.active),
    );

    return Scaffold(
      body: view.map(
        singular: (state) => SingularLibraryDisplay(category: state.category),
        tabular: (state) => TabularLibraryDisplay(categories: state.categories),
      ),
      bottomNavigationBar: ImplicitAnimatedBottomBar(
        visible: selectionActive,
        child: CustomBottomBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IconButton(
                tooltip: "Set categories",
                onPressed: null,
                icon: Icon(Icons.category),
              ),
              IconButton(
                tooltip: "Mark as read",
                onPressed: () {},
                icon: const Icon(Icons.check),
              ),
              IconButton(
                tooltip: "Mark as unread",
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
              IconButton(
                tooltip: "Delete",
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
