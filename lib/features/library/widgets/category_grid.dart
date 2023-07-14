import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';

class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryData category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryNovelsFamily(category.id));

    final selectionActive = ref.watch(
        librarySelectionProvider.select((selection) => selection.active));
    final selectionNotifier = ref.watch(librarySelectionProvider.notifier);

    final slivers = state.when(
      loading: () => [],
      error: (error, stack) => [
        SliverFillLoadingError(
          message: Text(error.toString()),
        )
      ],
      data: (data) => [
        if (data.isEmpty)
          const SliverFillEmptyIndicator(
            icon: Icon(Icons.category),
            label: Text('Category is empty'),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final novel = data[index];

                  return Consumer(
                    builder: (context, ref, child) {
                      final selected = ref.watch(
                        librarySelectionProvider.select((selection) =>
                            selection.selected.contains(novel.id)),
                      );

                      void select() => selectionNotifier.toggle(novel.id);

                      return NovelGridCard(
                        title: novel.title,
                        coverUrl: novel.coverUrl,
                        onTap: selectionActive
                            ? select
                            : () => context.router.push(NovelRoute(
                                  type: NovelType.novel(novel),
                                )),
                        onLongPress: selectionActive ? null : select,
                        selected: selected,
                      );
                    },
                  );
                },
                childCount: data.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 2 / 3,
              ),
            ),
          )
      ],
    );

    return CustomScrollView(
      slivers: [
        ...slivers,
        const SliverToBoxAdapter(
          child: NavigationOffset(),
        ),
      ],
    );
  }
}
