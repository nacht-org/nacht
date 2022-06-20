import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

import '../presentation.dart';

class ReaderBody extends HookConsumerWidget {
  const ReaderBody({
    Key? key,
    required this.reader,
    required this.controller,
  }) : super(key: key);

  final ReaderInfo reader;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactory = ref.watch(crawlerFactoryFamily(reader.novel.url));
    final toolbarNotifier = ref.watch(toolbarProvider.notifier);

    if (crawlerFactory == null) {
      return Center(
        child: Text('uh oh.'),
      );
    }

    return GestureDetector(
      onTap: toolbarNotifier.toggle,
      child: PageView.builder(
        controller: controller,
        itemCount: reader.novel.chapters.length,
        itemBuilder: (context, index) {
          return ChapterPage(
            novel: reader.novel,
            chapter: reader.novel.chapters[index],
            crawlerFactory: crawlerFactory,
          );
        },
        onPageChanged: (index) =>
            ref.read(readerFamily(reader).notifier).setCurrentIndex,
      ),
    );
  }
}
