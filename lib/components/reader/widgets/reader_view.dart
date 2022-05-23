import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../provider/active_chapter_provider.dart';
import '../provider/reader_novel_provider.dart';
import '../provider/toolbar_provider.dart';
import 'reader_body.dart';

class ReaderView extends HookConsumerWidget {
  const ReaderView({
    Key? key,
    required this.novel,
    required this.chapter,
  }) : super(key: key);

  final NovelData novel;
  final ChapterData chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final novelInfo = ref.watch(readerNovelProvider(novel));
    final toolbarVisible =
        ref.watch(toolbarProvider.select((toolbar) => toolbar.visible));

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
      initialValue: 1,
    );

    useEffect(() {
      ref.read(toolbarProvider.notifier).setSystemUiMode(toolbarVisible);
      return null;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        // Make sure status bar is visible when exiting reader
        ref.read(toolbarProvider.notifier).setSystemUiMode(true);
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: SlidingPrefferedSize(
          controller: controller,
          visible: toolbarVisible,
          child: AppBar(
            title: Consumer(builder: (context, ref, child) {
              final active = ref.watch(activeChapterProvider(novelInfo));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    novel.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.appBarTheme.foregroundColor,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    active?.title ?? chapter.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                    maxLines: 1,
                  ),
                ],
              );
            }),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
        body: ReaderBody(novel: novelInfo, chapter: chapter),
      ),
    );
  }
}
