import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';

class DownloadAction extends ConsumerWidget {
  const DownloadAction({
    super.key,
    required this.novel,
  });

  final NovelData novel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            final chapterList = ref.read(chapterListFamily(novel.id));
            final chaptersToDownload = chapterList.chapters
                .where((c) => c.content == null && c.readAt == null)
                .map((e) => DownloadRelatedData.from(novel, e));

            ref.read(downloadListProvider.notifier).addMany(chaptersToDownload);
          },
          child: const Text("Unread"),
        ),
        PopupMenuItem(
          onTap: () {
            final chapterList = ref.read(chapterListFamily(novel.id));
            final chaptersToDownload = chapterList.chapters
                .where((c) => c.content == null)
                .map((e) => DownloadRelatedData.from(novel, e));

            ref.read(downloadListProvider.notifier).addMany(chaptersToDownload);
          },
          child: const Text("All"),
        ),
      ],
      icon: const Icon(Icons.download),
    );
  }
}
