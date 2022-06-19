import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation.dart';

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
    final crawler = ref.watch(crawlerFamily(crawlerFactory));
    final input = ReaderPageInfo.from(chapter, crawler);

    final page = ref.watch(readerPageFamily(input));
    final notifier = ref.watch(readerPageFamily(input).notifier);

    usePostFrameCallback((timeStamp) {
      notifier.fetch(crawler);
    });

    return page.content.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (content) => NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.isAtEnd) {
            ref
                .read(chapterFamily(ChapterInput(chapter)).notifier)
                .markAsRead();
          }
          return false;
        },
        child: ReaderTheme(
          child: Scrollbar(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 16.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Builder(builder: (context) {
                    var theme = Theme.of(context);

                    return Text(
                      chapter.title,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.textTheme.labelLarge?.color,
                      ),
                    );
                  }),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final preferences = ref.watch(readerPreferencesProvider);

                    return Html(
                      data: content,
                      style: {
                        "*": Style(
                          lineHeight: LineHeight(preferences.lineHeight),
                        ),
                        "p": Style(
                          fontSize: FontSize(preferences.fontSize),
                        ),
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
