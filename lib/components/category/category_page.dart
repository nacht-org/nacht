import 'package:chapturn/components/category/provider/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/add_dialog.dart';
import 'widgets/category_list.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoaded = ref.watch(
      categoriesProvider.select((value) => value != null),
    );

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('Categories'),
            floating: true,
            forceElevated: innerBoxIsScrolled,
          )
        ],
        body: const CategoryList(),
      ),
      floatingActionButton: isLoaded
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
