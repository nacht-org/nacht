import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class ReaderBody extends HookConsumerWidget {
  const ReaderBody({
    Key? key,
    required this.reader,
    required this.notifier,
    required this.controller,
  }) : super(key: key);

  final ReaderInfo reader;
  final ReaderNotifier notifier;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactory = ref.watch(crawlerFactoryFamily(reader.novel.url));
    final toolbarNotifier = ref.watch(toolbarProvider.notifier);

    final chapterList = ref.watch(chapterListFamily(reader.novel.id));

    if (crawlerFactory == null) {
      return Center(
        child: Text('uh oh.'),
      );
    }

    return GestureDetector(
      onTap: toolbarNotifier.toggle,
      child: PageView.builder(
        controller: controller,
        itemCount: chapterList.chapters.length,
        itemBuilder: (context, index) {
          return ChapterPage(
            novel: reader.novel,
            index: index,
            crawlerFactory: crawlerFactory,
          );
        },
        onPageChanged: notifier.setCurrentIndex,
      ),
    );
  }
}
