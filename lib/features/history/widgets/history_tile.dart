import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';

import '../providers/providers.dart';

class HistoryTile extends ConsumerWidget {
  const HistoryTile({
    Key? key,
    required this.history,
  }) : super(key: key);

  final HistoryData history;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(historySelectionProvider
        .select((selection) => selection.selected.contains(history.id)));
    final selectionActive = ref.watch(
        historySelectionProvider.select((selection) => selection.active));

    final selectionNotifier = ref.watch(historySelectionProvider.notifier);
    void select() => selectionNotifier.toggle(history.id);

    return ListTile(
      leading: NovelAvatar(
        novel: NovelType.novel(history.novel),
      ),
      title: Text(
        history.novel.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        history.chapter.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        "${history.updatedAt.hour}:${history.updatedAt.minute}",
      ),
      onTap: selectionActive
          ? select
          : () => context.router.push(
                ReaderRoute(
                  novel: history.novel,
                  chapter: history.chapter,
                ),
              ),
      onLongPress: selectionActive ? null : select,
      selected: selected,
    );
  }
}
