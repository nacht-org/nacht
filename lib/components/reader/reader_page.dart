import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';
import 'provider/active_chapter_provider.dart';
import 'provider/reader_novel_provider.dart';
import 'widgets/reader_body.dart';

class ReaderPage extends ConsumerWidget {
  const ReaderPage({
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

    return Scaffold(
      appBar: AppBar(
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
      ),
      // extendBodyBehindAppBar: true,
      body: ReaderBody(novel: novelInfo, chapter: chapter),
      extendBody: true,
    );
  }
}
