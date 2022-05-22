import 'package:chapturn/components/reader/provider/toolbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import '../model/novel_info.dart';
import '../provider/active_chapter_provider.dart';
import 'chapter_page.dart';

class ReaderBody extends HookConsumerWidget {
  const ReaderBody({
    Key? key,
    required this.novel,
    required this.chapter,
  }) : super(key: key);

  final NovelInfo novel;
  final ChapterData chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactory = ref.watch(crawlerFactoryProvider(novel.data.url));
    final index = novel.chapters.indexOf(chapter);
    final toolbarNotifier = ref.watch(toolbarProvider.notifier);

    final controller = usePageController(initialPage: index);

    return crawlerFactory.fold(
      () => Center(
        child: Text('uh oh.'),
      ),
      (data) => GestureDetector(
        onTap: toolbarNotifier.toggle,
        child: PageView.builder(
          controller: controller,
          itemCount: novel.chapters.length,
          itemBuilder: (context, index) {
            return ChapterPage(
              novel: novel,
              chapter: novel.chapters[index],
              crawlerFactory: data,
            );
          },
          onPageChanged: (index) {
            ref.read(activeIndexProvider.notifier).state = index;
            ref.read(toolbarProvider.notifier).hide();
          },
        ),
      ),
    );
  }
}
