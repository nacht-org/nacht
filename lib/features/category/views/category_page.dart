import 'package:auto_route/annotations.dart';
import 'package:nacht/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

@RoutePage()
class CategoryPage extends ConsumerWidget with LoggerMixin {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(categoriesSelectionProvider);
    SelectionNotifier.handleRoute(context, ref, categoriesSelectionProvider);

    return Scaffold(
      appBar: selection.active
          ? AppBar(
              leading: const CloseButton(),
              title: Text('${selection.selected.length}'),
              actions: [
                Consumer(builder: (context, ref, child) {
                  final selected = ref.watch(categoriesSelectionProvider
                      .select((value) => value.selected));

                  return IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(categoriesPageProvider.notifier)
                          .remove(selected);
                      Navigator.of(context).pop();
                    },
                  );
                }),
              ],
            )
          : AppBar(
              title: const Text('Edit categories'),
            ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: const CategoryList(),
      ),
      floatingActionButton: !selection.active
          ? FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const AddCategoryDialog(),
              ),
              tooltip: 'Add category',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
