import 'package:chapturn/components/category/provider/categories_provider.dart';
import 'package:chapturn/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryList extends HookConsumerWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final notifier = ref.watch(categoriesProvider.notifier);

    final refreshKey = useRefresh();

    return RefreshIndicator(
      key: refreshKey,
      onRefresh: notifier.reload,
      child: CustomScrollView(
        slivers: [
          if (categories != null)
            SliverReorderableList(
              itemBuilder: (context, index) {
                final category = categories[index];

                return ListTile(
                  key: Key('${category.id}'),
                  title: Text(category.name),
                );
              },
              itemCount: categories.length,
              onReorder: (oldIndex, newIndex) {},
            ),
          if (categories != null && categories.isEmpty)
            const SliverFillRemaining(
              child: Icon(
                Icons.category,
                size: 48,
              ),
              hasScrollBody: false,
            )
        ],
      ),
    );
  }
}
