import 'package:chapturn/components/library/widgets/category_grid.dart';
import 'package:chapturn/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/domain.dart';

class TabularLibraryDisplay extends HookWidget {
  const TabularLibraryDisplay({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<CategoryData> categories;

  @override
  Widget build(BuildContext context) {
    final controller = useTabController(initialLength: categories.length);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('Library'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
          bottom: AlignTabBar(
            child: TabBar(
              controller: controller,
              tabs: categories
                  .map((category) => Tab(text: category.name))
                  .toList(),
              isScrollable: true,
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: controller,
        children: categories
            .map((category) => CategoryGrid(category: category))
            .toList(),
      ),
    );
  }
}
