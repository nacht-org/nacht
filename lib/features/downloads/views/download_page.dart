import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class DownloadPage extends ConsumerWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final download = ref.watch(downloadProvider);
    final notifier = ref.watch(downloadProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Download queue'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () =>
                    ref.read(downloadListProvider.notifier).removeAll(),
                child: const Text('Cancel all'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: const DownloadView(),
      floatingActionButton: download.isRunning
          ? FloatingActionButton(
              onPressed: () => notifier.setRunning(false),
              child: const Icon(Icons.pause),
            )
          : FloatingActionButton(
              onPressed: () => notifier.setRunning(true),
              child: const Icon(Icons.play_arrow),
            ),
    );
  }
}

class DownloadView extends ConsumerWidget {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloads = ref.watch(downloadListProvider);

    if (downloads.order.isEmpty) {
      return const EmptyIndicator(
        child: Icon(Icons.download),
      );
    }

    return ListView.builder(
      itemCount: downloads.order.length,
      itemBuilder: (context, index) {
        final download = downloads.data[downloads.order[index]];

        if (download == null) {
          return const SizedBox.shrink();
        }

        return ListTile(
          title: Text(
            download.related.novelTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            download.related.chapterTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: DownloadButton(
            related: download.related,
            assetId: null,
          ),
        );
      },
    );
  }
}
