import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

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

    return ReaderTheme(
      child: page.content.when(
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
        data: (content) => ChapterLoaded(
          novel: novel,
          index: index,
          chapter: data,
          content: content,
        ),
      ),
    );
  }
}

class ChapterLoaded extends HookConsumerWidget {
  const ChapterLoaded({
    super.key,
    required this.novel,
    required this.index,
    required this.chapter,
    required this.content,
  });

  final NovelData novel;
  final int index;
  final ChapterData chapter;
  final String content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    usePostFrameCallback((timeStamp) {
      ref
          .read(historySessionProvider(novel.id).notifier)
          .record(novel, chapter);
    });

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.isAtEnd) {
          ref.read(chapterListFamily(novel.id).notifier).markAsRead(index);
        }
        return false;
      },
      child: ReaderScrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0).copyWith(top: 0),
          child: Consumer(
            builder: (context, ref, child) {
              final theme = Theme.of(context);
              final preferences = ref.watch(readerPreferencesProvider);

              return HtmlWidget(
                "<chapter-title></chapter-title>"
                "$content"
                "<bottom-padding></bottom-padding>",
                buildAsync: false,
                enableCaching: true,
                rebuildTriggers: [preferences],
                customWidgetBuilder: (element) {
                  if (element.localName == 'chapter-title') {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Builder(
                        builder: (context) {
                          final theme = Theme.of(context);

                          return Text(
                            chapter.title,
                            style: theme.textTheme.displaySmall?.copyWith(
                              color: theme.textTheme.labelLarge?.color,
                            ),
                          );
                        },
                      ),
                    );
                  } else if (element.localName == 'bottom-padding') {
                    return SizedBox(
                      height: MediaQuery.paddingOf(context).bottom,
                    );
                  }

                  return null;
                },
                factoryBuilder: () => ReaderWidgetFactory(),
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: preferences.fontSize,
                  height: preferences.lineHeight,
                ),
                renderMode: RenderMode.column,
                // renderMode: const ListViewMode(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                // ),
              );
            },
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

class ReaderWidgetFactory extends WidgetFactory
    with UrlLauncherFactory, CachedNetworkImageFactory {}
