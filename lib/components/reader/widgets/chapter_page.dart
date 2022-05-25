import 'package:chapturn/components/reader/model/chapter_info.dart';
import 'package:chapturn/components/reader/provider/chapter_provider.dart';
import 'package:chapturn/extrinsic/extrinsic.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import '../model/novel_info.dart';

class ChapterPage extends HookConsumerWidget {
  const ChapterPage({
    Key? key,
    required this.novel,
    required this.chapter,
    required this.crawlerFactory,
  }) : super(key: key);

  final NovelInfo novel;
  final ChapterData chapter;
  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawler = ref.watch(crawlerProvider(crawlerFactory));
    final input = ChapterInfo.fromChapterData(chapter, novel.data, crawler);
    final info = ref.watch(chapterProvider(input));
    final notifier = ref.watch(chapterProvider(input).notifier);

    usePostFrameCallback((timeStamp) {
      notifier.fetch();
    });

    return info.content.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (content) => NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          notifier.readToEnd();
          return false;
        },
        child: Scrollbar(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 32.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  chapter.title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Html(data: content),
            ],
          ),
        ),
      ),
    );
  }
}
