import 'package:chapturn/components/reader/provider/chapter_provider.dart';
import 'package:chapturn/extrinsic/extrinsic.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';

class ReaderBody extends HookConsumerWidget {
  const ReaderBody({
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
    final info = ref.watch(chapterProvider(Tuple2(chapter, crawler)));
    final notifier =
        ref.watch(chapterProvider(Tuple2(chapter, crawler)).notifier);

    usePostFrameCallback((timeStamp) {
      notifier.fetch();
    });

    return info.content.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (content) => Scrollbar(
        child: SingleChildScrollView(
          child: Html(data: content),
        ),
      ),
    );
  }
}
