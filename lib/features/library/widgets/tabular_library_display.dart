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
    final selectionNotifier = ref.watch(librarySelectionProvider.notifier);

    return Scaffold(
      appBar: selection.active
          ? SelectionAppBar(
              title: Text("${selection.selected.length}"),
              bottom: buildTabBar(),
              onSelectAllPressed: () async {
                if (!tabController.indexIsChanging) {
                  selectionNotifier.addAll(await getIds());
                }
              },
              onInversePressed: () async {
                if (!tabController.indexIsChanging) {
                  selectionNotifier.flipAll(await getIds());
                }
              },
            )
          : AppBar(
              title: const Text('Library'),
              bottom: buildTabBar(),
            ),
      body: TabBarView(
        controller: tabController,
        children: widget.categories
            .map((category) => CategoryGrid(
                  category: category,
                ))
            .toList(),
      ),
    );
  }

  PreferredSizeWidget buildTabBar() {
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

  /// Get ids of novels in current category.
  Future<Iterable<int>> getIds() async {
    final category = widget.categories[tabController.index];
    final novels = await ref.read(categoryNovelsFamily(category.id).future);
    return novels.map((novel) => novel.id);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    scrollController.dispose();
  }
}
