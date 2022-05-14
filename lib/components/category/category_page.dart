import 'package:chapturn/core/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider/categories_provider.dart';
import 'provider/selection_provider.dart';
import 'widgets/add_dialog.dart';
import 'widgets/category_list.dart';

class CategoryPage extends ConsumerWidget with LoggerMixin {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoaded =
        ref.watch(categoriesProvider.select((value) => value != null));

    final selection = ref.watch(selectionProvider);
    ref.listen<SelectionInfo>(selectionProvider, (previous, next) {
      if ((previous == null || previous.selected.isEmpty) &&
          next.selected.isNotEmpty) {
        log.fine('an item has been newly selected, entering selecting mode');
        ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
          onRemove: () {
            log.fine('exiting selecting mode');
            ref.read(selectionProvider.notifier).deactivate();
          },
        ));
      }

      if (previous != null &&
          previous.selected.isNotEmpty &&
          next.active &&
          next.selected.isEmpty) {
        log.fine('all items have been unselected, popping local route context');
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          if (!selection.active)
            SliverAppBar(
              title: const Text('Edit categories'),
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          if (selection.active)
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: Navigator.of(context).pop,
              ),
              title: Text('${selection.selected.length}'),
              floating: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                Consumer(builder: (context, ref, child) {
                  final selected = ref.watch(
                      selectionProvider.select((value) => value.selected));

                  return IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(categoriesProvider.notifier).remove(selected);
                      Navigator.of(context).pop();
                    },
                  );
                }),
              ],
            ),
        ],
        body: const CategoryList(),
      ),
      floatingActionButton: isLoaded && !selection.active
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const AddCategoryDialog(),
              ),
              tooltip: 'Add category',
            )
          : null,
    );
  }
}
