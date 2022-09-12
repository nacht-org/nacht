import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/home/providers/navigation_provider.dart';
import 'package:nacht/features/library/providers/providers.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/nht/nht.dart';
import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

import 'widgets.dart';

class TabularLibraryDisplay extends ConsumerStatefulWidget {
  const TabularLibraryDisplay({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<CategoryData> categories;

  @override
  ConsumerState<TabularLibraryDisplay> createState() =>
      _TabularLibraryDisplayState();
}

class _TabularLibraryDisplayState extends ConsumerState<TabularLibraryDisplay>
    with TickerProviderStateMixin {
  late TabController tabController;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: widget.categories.length, vsync: this);
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(navigationProvider.notifier).attach(scrollController);
    });
  }

  @override
  void didUpdateWidget(covariant TabularLibraryDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categories.length != widget.categories.length) {
      tabController.dispose();
      tabController =
          TabController(length: widget.categories.length, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selection = ref.watch(librarySelectionProvider);

    return NestedScrollView(
      controller: scrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: selection.active
              ? SliverSelectionAppBar(
                  title: Text("${selection.selected.length}"),
                  bottom: buildTabBar(),
                  floating: true,
                )
              : SliverAppBar(
                  title: const Text('Library'),
                  floating: true,
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: buildTabBar(),
                ),
        ),
      ],
      body: DestinationTransition(
        child: TabBarView(
          controller: tabController,
          children: widget.categories
              .map((category) => CategoryGrid(
                    category: category,
                    pinned: true,
                  ))
              .toList(),
        ),
      ),
    );
  }

  AlignTabBar buildTabBar() {
    return AlignTabBar(
      child: TabBar(
        controller: tabController,
        tabs: widget.categories
            .map((category) => Tab(text: category.name))
            .toList(),
        isScrollable: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    ref.read(navigationProvider.notifier).detach(scrollController);
    scrollController.dispose();
  }
}
