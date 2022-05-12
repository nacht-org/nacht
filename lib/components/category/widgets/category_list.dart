import 'package:chapturn/components/category/provider/categories_provider.dart';
import 'package:chapturn/components/category/widgets/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryList extends HookConsumerWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final notifier = ref.watch(categoriesProvider.notifier);

    useEffect(() {
      notifier.reload();
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
      onRefresh: notifier.reload,
      child: ReorderableListView.builder(
        itemBuilder: (context, index) {
          final category = categories[index];

          return ListTile(
            leading: ReorderableDelayedDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
            key: Key('${category.id}'),
            title: Text(category.name),
            onTap: () => showDialog(
              context: context,
              builder: (context) => EditCategoryDialog(categoryData: category),
            ),
          );
        },
        buildDefaultDragHandles: false,
        itemCount: categories.length,
        onReorder: notifier.reorder,
      ),
    );
  }
}
