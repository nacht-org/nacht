import 'package:nacht/components/reader/model/reader_page_info.dart';
import 'package:nacht/extrinsic/extrinsic.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import '../provider/reader_page_provider.dart';
import 'reader_theme.dart';

class ChapterPage extends HookConsumerWidget {
  const ChapterPage({
    Key? key,
    required this.novel,
    required this.chapter,
    required this.crawlerFactory,
  }) : super(key: key);

  final NovelData novel;
  final ChapterData chapter;
  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawler = ref.watch(crawlerProvider(crawlerFactory));
    final input = ReaderPageInfo.from(chapter, crawler);

    final page = ref.watch(readerPageProvider(input));
    final notifier = ref.watch(readerPageProvider(input).notifier);

    usePostFrameCallback((timeStamp) {
      notifier.fetch();
    });

    return page.content.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (content) => NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          ref
              .read(chapterProvider(ChapterInput(chapter)).notifier)
              .markAsRead();
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
              ReaderTheme(
                child: Html(
                  data: content,
                  style: {
                    "p": Style(),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
