import 'package:chapturn/components/reader/provider/chapter_provider.dart';
import 'package:chapturn/core/widgets/sliding_preferred_size.dart';
import 'package:chapturn/extrinsic/extrinsic.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import '../model/novel_info.dart';
import '../provider/toolbar_provider.dart';

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
    final info = ref.watch(chapterProvider(Tuple2(chapter, crawler)));
    final notifier =
        ref.watch(chapterProvider(Tuple2(chapter, crawler)).notifier);
    final toolbarVisible =
        ref.watch(toolbarProvider.select((toolbar) => toolbar.visible));

    usePostFrameCallback((timeStamp) {
      notifier.fetch();
    });

    return info.content.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (content) => Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: toolbarVisible ? MediaQuery.of(context).padding.top : 0,
            ),
            Html(data: content),
          ],
        ),
      ),
    );
  }
}