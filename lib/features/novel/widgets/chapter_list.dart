import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/downloads/models/models.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';

class ChapterList extends ConsumerWidget {
  const ChapterList({
    Key? key,
    required this.novel,
  }) : super(key: key);

  final NovelData novel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);

    final chapterList = ref.watch(chapterListFamily(novel.id));
    final entries = ref.watch(chapterListEntriesFamily(chapterList.chapters));

    final dateFormatService = ref.watch(dateFormatServiceFamily(locale));

    final selectionActive =
        ref.watch(novelSelectionProvider.select((value) => value.active));
    final selectionNotifier = ref.watch(novelSelectionProvider.notifier);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return entries[index].when(
            volume: (volume) => ListTile(
              title: Text(
                volume.name.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              dense: true,
            ),
            chapter: (data) => Consumer(
              builder: (context, ref, child) {
                final selected = ref.watch(novelSelectionProvider
                    .select((value) => value.contains(data.id)));

                void select() => selectionNotifier.toggle(data.id);

                return ListTile(
                  title: Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: data.updated == null
                      ? null
                      : Text(dateFormatService.relativeDay(data.updated!)),
                  trailing: DownloadButton(
                    related: DownloadRelatedData.from(novel, data),
                    isDownloaded: data.content != null,
                  ),
                  onTap: selectionActive
                      ? select
                      : () => context.router.push(
                            ReaderRoute(
                              novel: novel,
                              chapter: data,
                            ),
                          ),
                  onLongPress: selectionActive ? null : select,
                  selected: selected,
                );
              },
            ),
          );
        },
        childCount: entries.length,
      ),
    );
  }
}
