import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/features/updates/providers/updates_selection_provider.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class ChapterUpdateTile extends ConsumerWidget {
  const ChapterUpdateTile({
    super.key,
    required this.novel,
    required this.chapter,
  });

  final NovelData novel;
  final ChapterData chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionActive = ref.watch(
        updatesSelectionProvider.select((selection) => selection.active));
    final selected = ref.watch(updatesSelectionProvider
        .select((value) => value.selected.contains(chapter.id)));

    final selectionNotifier = ref.watch(updatesSelectionProvider.notifier);
    void select() => selectionNotifier.toggle(chapter.id);

    return MuteTile(
      muted: chapter.readAt != null,
      child: ListTile(
        leading: NovelAvatar(
          novel: NovelType.novel(novel),
        ),
        title: Text(
          novel.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          chapter.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: DownloadButton(
          related: DownloadRelatedData.from(novel, chapter),
          assetId: chapter.content,
        ),
        onTap: selectionActive
            ? select
            : () {
                context.router.push(
                  ReaderRoute(
                    novel: novel,
                    chapter: chapter,
                  ),
                );
              },
        contentPadding: kTrailingListTilePadding,
        onLongPress: selectionActive ? null : select,
        selected: selected,
      ),
    );
  }
}
