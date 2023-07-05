import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../services/services.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

@RoutePage()
class LibraryPage extends HookConsumerWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = Navigator.of(context);
    final view = ref.watch(libraryViewProvider);

    final selectionActive = ref.watch(
      librarySelectionProvider.select((selection) => selection.active),
    );

    SelectionNotifier.handleRoute(context, ref, librarySelectionProvider);

    // Hide bottom navigation bar when selecting.
    // FIXME: only rely on selection active status. related to updates page.
    NavigationNotifier.handleHide(
      ref,
      librarySelectionProvider.select(
        (value) => value.active && value.selected.isNotEmpty,
      ),
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
                onPressed: () {
                  final selected = ref.read(librarySelectionProvider).selected;
                  ref.read(markReadManyNovel).execute(selected);
                  navigator.pop();
                },
                icon: const Icon(Icons.check),
              ),
              IconButton(
                tooltip: "Mark as unread",
                onPressed: () {
                  final selected = ref.read(librarySelectionProvider).selected;
                  ref.read(markUnreadManyNovel).execute(selected);
                  navigator.pop();
                },
                icon: const Icon(Icons.close),
              ),
              IconButton(
                tooltip: "Delete",
                onPressed: () async {
                  final selected = ref.read(librarySelectionProvider).selected;
                  final novel = "novel"
                      .pluralize(suffix: "s", test: (_) => selected.length > 1);

                  final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => ConfirmDialog(
                          title: const Text("Delete selected"),
                          message: Text(
                            "Selected $novel will be permanently removed from "
                            "library and all categories.",
                          ),
                        ),
                      ) ??
                      false;

                  if (confirm) {
                    await ref.read(removeNovelManyProvider).execute(selected);
                    navigator.pop();
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
