import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

class DownloadButton extends ConsumerWidget {
  const DownloadButton({
    super.key,
    required this.related,
    required this.assetId,
  });

  final DownloadRelatedData related;
  final int? assetId;

  bool get isDownloaded => assetId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(downloadListProvider
        .select((value) => value.dataFromChapterId(related.chapterId)));
    final notifier = ref.watch(downloadListProvider.notifier);

    final isDownloading = ref.watch(
      downloadProvider.select((download) =>
          download.current != null && download.current?.id == state?.id),
    );

    if (isDownloaded) {
      return _DownloadDone(
        chapterId: related.chapterId,
        assetId: assetId,
      );
    }

    if (state == null) {
      return _AddDownloadButton(
        onPressed: () => notifier.add(related),
      );
    }

    if (isDownloading) {
      // TODO: How to cancel downloads in progress.
      return _ProgressDownload(onCancel: () {});
    }

    return _PendingDownload(
      onCancel: () => notifier.remove(state.id),
    );
  }
}

class _AddDownloadButton extends StatelessWidget {
  const _AddDownloadButton({
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const _DownloadIndicator(),
    );
  }
}

class _PendingDownload extends StatelessWidget {
  const _PendingDownload({required this.onCancel});

  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: onCancel,
          child: const Text('Cancel'),
        ),
      ],
      icon: const _DownloadIndicator(
        progress: null,
      ),
    );
  }
}

class _ProgressDownload extends StatelessWidget {
  const _ProgressDownload({
    required this.onCancel,
  });

  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: onCancel,
          child: const Text('Cancel'),
        ),
      ],
      icon: const _DownloadIndicator(
        progress: 0.5,
      ),
    );
  }
}

class _DownloadDone extends ConsumerWidget {
  const _DownloadDone({
    required this.chapterId,
    required this.assetId,
  });

  final int chapterId;
  final int? assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final delete = ref.watch(deleteDownloadedChapter);
    final iconTheme = IconTheme.of(context);

    return PopupMenuButton(
      itemBuilder: (context) => [
        if (assetId != null)
          PopupMenuItem(
            onTap: () => delete.call(chapterId, assetId!),
            child: const Text('Delete'),
          ),
      ],
      icon: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: iconTheme.color ?? theme.colorScheme.onSurface,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.done,
            size: 18,
            color: theme.colorScheme.background,
          ),
        ),
      ),
    );
  }
}

class _DownloadIndicator extends StatelessWidget {
  const _DownloadIndicator({
    this.color,
    this.progress = 1,
  });

  final Color? color;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final color = this.color ?? iconTheme.color;

    return SizedBox.square(
      dimension: 24.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Icon(
                Icons.download,
                size: 18,
                color: color,
              ),
            ),
          ),
          CircularProgressIndicator(
            value: progress,
            color: color,
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
