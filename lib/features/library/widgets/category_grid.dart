import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryData category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionActive = ref.watch(
        librarySelectionProvider.select((selection) => selection.active));
    final selectionNotifier = ref.watch(librarySelectionProvider.notifier);

    final gridSize = ref
        .watch(novelGridPreferencesProvider.select((value) => value.gridSize));

    return CategoryLoader(
      category: category,
      builder: (context, novels) {
        return GridView.builder(
          padding: const EdgeInsets.all(8.0)
              .add(const EdgeInsets.only(bottom: 80.0)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize ?? 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (context, index) {
            final novel = novels[index];

            return Consumer(
              builder: (context, ref, child) {
                final selected = ref.watch(
                  librarySelectionProvider.select(
                      (selection) => selection.selected.contains(novel.id)),
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
          itemCount: novels.length,
        );
      },
    );
  }
}
