import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/novel/provider/novel_selection_provider.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import '../../components.dart';

class ChapterList extends ConsumerWidget {
  const ChapterList({Key? key, required this.novel}) : super(key: key);

  final NovelData novel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(chapterListProvider(novel));
    final timeService = ref.watch(timeServiceProvider);

    final selectionActive =
        ref.watch(novelSelectionProvider.select((value) => value.active));
    final selectionNotifier = ref.watch(novelSelectionProvider.notifier);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return items[index].when(
            volume: (volume) => ListTile(
              title: Text(
                volume.name.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              dense: true,
            ),
            chapter: (data) => Consumer(builder: (context, ref, child) {
              final chapter = ref.watch(chapterProvider(ChapterInput(data)));
              final selected = ref.watch(novelSelectionProvider
                  .select((value) => value.contains(chapter.id)));

              void select() => selectionNotifier.toggle(chapter.id);

              return NachtListTile(
                title: Text(
                  chapter.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: chapter.updated == null
                    ? null
                    : Text(timeService.formatChapterUpdated(chapter.updated!)),
                onTap: selectionActive
                    ? select
                    : () => context.router.push(
                          ReaderRoute(
                            novel: novel,
                            chapter: chapter,
                            doFetch: false,
                          ),
                        ),
                onLongPress: selectionActive ? null : select,
                selected: selected,
                muted: chapter.readAt != null,
              );
            }),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
