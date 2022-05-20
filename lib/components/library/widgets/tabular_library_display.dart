import 'package:chapturn/extrinsic/extrinsic.dart';
import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import 'category_grid.dart';

class TabularLibraryDisplay extends StatefulWidget {
  const TabularLibraryDisplay({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<CategoryData> categories;

  @override
  State<TabularLibraryDisplay> createState() => _TabularLibraryDisplayState();
}

class _TabularLibraryDisplayState extends State<TabularLibraryDisplay>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: widget.categories.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant TabularLibraryDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categories.length != widget.categories.length) {
      controller.dispose();
      controller = TabController(length: widget.categories.length, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              tabs: widget.categories
                  .map((category) => Tab(text: category.name))
                  .toList(),
              isScrollable: true,
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: controller,
        children: widget.categories
            .map((category) => CategoryGrid(category: category))
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
