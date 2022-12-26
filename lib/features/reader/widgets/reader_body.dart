import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/reader/providers/history_session_provider.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class ReaderBody extends HookConsumerWidget {
  const ReaderBody({
    Key? key,
    required this.reader,
    required this.readerNotifier,
    required this.controller,
  }) : super(key: key);

  final ReaderInfo reader;
  final ReaderNotifier readerNotifier;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactory = ref.watch(crawlerFactoryFamily(reader.novel.url));
    final toolbarNotifier = ref.watch(toolbarProvider.notifier);

    final chapterList = ref.watch(chapterListFamily(reader.novel.id));
    final historySessionNotifier =
        ref.watch(historySessionProvider(reader.novel.id).notifier);

    if (crawlerFactory == null) {
      return const Center(
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
        onPageChanged: (index) {
          readerNotifier.setCurrentIndex(index);
          historySessionNotifier.update(chapterList.chapters[index]);
        },
      ),
    );
  }
}
