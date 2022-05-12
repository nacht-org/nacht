import 'package:chapturn/components/library/provider/relevant_categories_provider.dart';
import 'package:chapturn/components/library/widgets/library_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants.dart';

class LibraryAppBar extends ConsumerWidget {
  const LibraryAppBar({Key? key, this.forceElevated = false}) : super(key: key);

  final bool forceElevated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(tabControllerProvider);
    final categories = ref.watch(relevantCategoriesProvider);

    return SliverAppBar(
      title: const Text('Library'),
      floating: true,
      forceElevated: forceElevated,
      bottom: categories.length > 1
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kTabHeight),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: controller,
                  tabs: categories
                      .map((category) => Tab(text: category.name))
                      .toList(),
                  isScrollable: true,
                ),
              ),
            )
          : null,
    );
  }
}
