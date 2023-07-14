import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class CategoryList extends HookConsumerWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesPageProvider);
    final categoriesNotifier = ref.watch(categoriesPageProvider.notifier);

    final selection = ref.watch(categoriesSelectionProvider);
    final selectionNotifier = ref.watch(categoriesSelectionProvider.notifier);

    if (categories.isEmpty) {
      return const EmptyIndicator(
        icon: Icon(Icons.category),
        label: Text('No categories found'),
      );
    }

    return RefreshIndicator(
      onRefresh: categoriesNotifier.reload,
      child: ReorderableListView.builder(
        padding: MediaQuery.paddingOf(context),
        itemBuilder: (context, index) {
          final category = categories[index];

          return Consumer(
            key: Key('${category.id}'),
            builder: (context, ref, child) {
              final selected = ref.watch(categoriesSelectionProvider
                  .select((value) => value.contains(category.id)));

              return ListTile(
                leading: ReorderableDelayedDragStartListener(
                  index: index,
                  enabled: !selection.active,
                  child: const Icon(Icons.drag_handle),
                ),
                title: Text(category.name),
                onTap: selection.active
                    ? () => selectionNotifier.toggle(category.id)
                    : () => showDialog(
                          context: context,
                          builder: (context) =>
                              EditCategoryDialog(categoryData: category),
                        ),
                onLongPress: selection.active
                    ? null
                    : () => selectionNotifier.toggle(category.id),
                selected: selected,
              );
            },
          );
        },
        buildDefaultDragHandles: false,
        itemCount: categories.length,
        onReorder: categoriesNotifier.reorder,
      ),
    );
  }
}
