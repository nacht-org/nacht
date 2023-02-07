import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';

class DownloadQueueTile extends ConsumerWidget {
  const DownloadQueueTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPaused =
        ref.watch(downloadProvider.select((state) => !state.isRunning));
    final remaining =
        ref.watch(downloadListProvider.select((state) => state.order.length));

    final subtitle = [
      if (isPaused) "Paused",
      if (remaining > 0) "$remaining remaining",
    ].join(" • ");

    return ListTile(
      leading: const Icon(Icons.download),
      title: const Text('Download queue'),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      onTap: () => context.router.push(const DownloadRoute()),
    );
  }
}
