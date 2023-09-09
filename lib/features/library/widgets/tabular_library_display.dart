import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/library/providers/providers.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/nht/nht.dart';
import 'package:flutter/material.dart';

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
              actions: [
                IconButton(
                  onPressed: () => LibrarySheet.show(context),
                  icon: const Icon(Icons.filter_list),
                ),
                const SizedBox(width: 8.0), // Temporary padding
              ],
              bottom: buildTabBar(),
            ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: widget.categories
              .map(
                (category) => CategoryGrid(
                  category: category,
                ),
              )
              .toList(),
        ),
      ),
      extendBody: true,
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
