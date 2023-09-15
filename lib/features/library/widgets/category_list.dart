import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({
    super.key,
    required this.category,
  });

  final CategoryData category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionActive = ref.watch(
        librarySelectionProvider.select((selection) => selection.active));
    final selectionNotifier = ref.watch(librarySelectionProvider.notifier);

    return CategoryLoader(
      category: category,
      builder: (context, novels) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
          itemCount: novels.length,
          itemBuilder: (context, index) {
            final novel = novels[index];

            return Consumer(
              builder: (context, ref, child) {
                final selected = ref.watch(
                  librarySelectionProvider.select(
                      (selection) => selection.selected.contains(novel.id)),
                );

                void select() => selectionNotifier.toggle(novel.id);

                return ListTile(
                  leading: NovelAvatar(novel: NovelType.novel(novel)),
                  title: Text(
                    novel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
        );
      },
    );
  }
}
