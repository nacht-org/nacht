import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class ChapterPage extends HookConsumerWidget {
  const ChapterPage({
    Key? key,
    required this.novel,
    required this.index,
    required this.crawlerFactory,
  }) : super(key: key);

  final NovelData novel;
  final int index;
  final CrawlerFactory crawlerFactory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawler = ref.watch(crawlerFamily(crawlerFactory));

    final data = ref.watch(chapterListFamily(novel.id)
        .select((value) => value.chapters[index].copyWith(readAt: null)));

    final input = ReaderPageInfo.from(data, crawler);

    final page = ref.watch(readerPageFamily(input));
    final notifier = ref.watch(readerPageFamily(input).notifier);

    usePostFrameCallback((timeStamp) {
      notifier.reload(crawler);
    });

    return page.content.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (message) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoadingError(
          message: Text(message),
          onRetry: () => notifier.reload(crawler),
        ),
      ),
      data: (content) => NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.isAtEnd) {
            ref.read(chapterListFamily(novel.id).notifier).markAsRead(index);
          }
          return false;
        },
        child: ReaderTheme(
          child: ReaderScrollbar(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 16.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Builder(
                    builder: (context) {
                      final theme = Theme.of(context);

                      return Text(
                        data.title,
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: theme.textTheme.labelLarge?.color,
                        ),
                      );
                    },
                  ),
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
                      customRenders: {
                        tableMatcher(): tableRender(),
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

class ReaderScrollbar extends ConsumerWidget {
  const ReaderScrollbar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showScrollbar = ref.watch(
      verticalReaderPreferencesProvider.select((value) => value.showScrollbar),
    );

    return Scrollbar(
      thickness: showScrollbar ? null : 0.0,
      child: child,
    );
  }
}
