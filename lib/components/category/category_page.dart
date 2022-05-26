import 'package:nacht/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/provider/provider.dart';

import 'provider/categories_provider.dart';
import 'provider/categories_selection_provider.dart';
import 'widgets/add_dialog.dart';
import 'widgets/category_list.dart';

class CategoryPage extends ConsumerWidget with LoggerMixin {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoaded =
        ref.watch(categoriesProvider.select((value) => value != null));

    final selection = ref.watch(categoriesSelectionProvider);
    SelectionNotifier.handleRoute(categoriesSelectionProvider, ref, context);

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
              leading: const CloseBackButton(),
              title: Text('${selection.selected.length}'),
              floating: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                Consumer(builder: (context, ref, child) {
                  final selected = ref.watch(categoriesSelectionProvider
                      .select((value) => value.selected));

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
