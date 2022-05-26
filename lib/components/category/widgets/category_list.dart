import 'package:nacht/components/category/provider/categories_provider.dart';
import 'package:nacht/components/category/provider/categories_selection_provider.dart';
import 'package:nacht/components/category/widgets/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryList extends HookConsumerWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final categoriesNotifier = ref.watch(categoriesProvider.notifier);

    final selection = ref.watch(categoriesSelectionProvider);
    final selectionNotifier = ref.watch(categoriesSelectionProvider.notifier);

    useEffect(() {
      categoriesNotifier.reload();
      return null;
    }, []);

    if (categories == null) {
      return Container();
    } else if (categories.isEmpty) {
      return const Icon(
        Icons.category,
        size: 48,
      );
    }

    return RefreshIndicator(
      onRefresh: categoriesNotifier.reload,
      child: ReorderableListView.builder(
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
