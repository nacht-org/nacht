import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/nacht_theme/nacht_theme.dart';
import 'package:nacht/features/downloads/models/models.dart';
import 'package:nacht/shared/shared.dart';
import 'package:simple_animations/simple_animations.dart';

import '../providers/providers.dart';

class DownloadButton extends ConsumerWidget {
  const DownloadButton({
    super.key,
    required this.related,
  });

  final DownloadRelatedData related;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(downloadListProvider
        .select((value) => value.dataFromChapterId(related.chapterId)));
    final notifier = ref.watch(downloadListProvider.notifier);

    final isDownloading = ref.watch(
      downloadProvider.select((download) =>
          download.current != null && download.current?.id == state?.id),
    );

    final download = ref.watch(downloadProvider);

    if (state == null) {
      return _AddDownloadButton(
        onPressed: () => notifier.add(related),
      );
    }

    if (isDownloading) {
      return _ProgressDownload(onCancel: () {});
    }

    return const _PendingDownload(
      onCancel: null,
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
    final theme = Theme.of(context);
    final iconTheme = IconTheme.of(context);

    return _DownloadPopupMenu(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: onCancel,
          child: const Text('Cancel'),
        ),
      ],
      child: MirrorAnimationBuilder<Color?>(
        tween: ColorTween(
            begin: iconTheme.color, end: theme.colorScheme.onSurface),
        duration: kLongAnimationDuration,
        builder: (context, value, child) {
          return _DownloadIndicator(color: value);
        },
        curve: Curves.easeInOutSine,
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
    final theme = Theme.of(context);

    return _DownloadPopupMenu(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: onCancel,
          child: const Text('Cancel'),
        ),
      ],
      child: _DownloadIndicator(
        color: theme.colorScheme.onSurface,
        progress: null,
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

class _DownloadPopupMenu extends StatelessWidget {
  const _DownloadPopupMenu({
    required this.itemBuilder,
    required this.child,
  });

  final Widget child;
  final PopupMenuItemBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: PopupMenuButton(
          itemBuilder: itemBuilder,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
