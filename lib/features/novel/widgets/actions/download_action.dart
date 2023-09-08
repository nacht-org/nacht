import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';


class DownloadAction extends ConsumerWidget {
  const DownloadAction({
    super.key,
    required this.novel,
  });

  final NovelData novel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Iterable<DownloadRelatedData> getNonDownloaded([
      bool Function(ChapterData)? test,
    ]) {
      final chapterList = ref.read(chapterListFamily(novel.id));

      var output = chapterList.chapters.where((c) => c.content == null);
      if (test != null) {
        output = output.where(test);
      }

      return output.map((e) => DownloadRelatedData.from(novel, e));
    }

    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            final downloadList = ref.read(downloadListProvider);
            final download = getNonDownloaded((c) =>
                c.readAt == null &&
                !downloadList.chapters.containsKey(c.id)).firstOrNull;

            if (download == null) return;
            ref.read(downloadListProvider.notifier).add(download);
          },
          child: const Text("Next chapter"),
        ),
        PopupMenuItem(
          onTap: () {
            final downloadList = ref.read(downloadListProvider);
            final download = getNonDownloaded((c) =>
                c.readAt == null &&
                !downloadList.chapters.containsKey(c.id)).take(5);

            if (download.isEmpty) return;
            ref.read(downloadListProvider.notifier).addMany(download);
          },
          child: const Text("Next 5 chapters"),
        ),
        PopupMenuItem(
          onTap: () {
            final downloadList = ref.read(downloadListProvider);
            final download = getNonDownloaded((c) =>
                c.readAt == null &&
                !downloadList.chapters.containsKey(c.id)).take(10);

            if (download.isEmpty) return;
            ref.read(downloadListProvider.notifier).addMany(download);
          },
          child: const Text("Next 10 chapters"),
        ),
        PopupMenuItem(
          onTap: () {
            final download = getNonDownloaded((c) => c.readAt == null);
            if (download.isEmpty) return;
            ref.read(downloadListProvider.notifier).addMany(download);
          },
          child: const Text("Unread"),
        ),
        PopupMenuItem(
          onTap: () {
            final download = getNonDownloaded();
            if (download.isEmpty) return;
            ref.read(downloadListProvider.notifier).addMany(download);
          },
          child: const Text("All"),
        ),
      ],
      icon: const Icon(Icons.download),
    );
  }
}
