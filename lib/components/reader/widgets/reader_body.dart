import 'package:nacht/components/reader/model/reader_info.dart';
import 'package:nacht/components/reader/provider/toolbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/provider.dart';
import '../provider/reader_provider.dart';
import 'chapter_page.dart';

class ReaderBody extends HookConsumerWidget {
  const ReaderBody({
    Key? key,
    required this.reader,
  }) : super(key: key);

  final ReaderInfo reader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactory = ref.watch(crawlerFactoryProvider(reader.novel.url));
    final toolbarNotifier = ref.watch(toolbarProvider.notifier);

    final controller = usePageController(initialPage: reader.initialIndex);

    return crawlerFactory.fold(
      () => Center(
        child: Text('uh oh.'),
      ),
      (data) => GestureDetector(
        onTap: toolbarNotifier.toggle,
        child: PageView.builder(
          controller: controller,
          itemCount: reader.novel.chapters.length,
          itemBuilder: (context, index) {
            return ChapterPage(
              novel: reader.novel,
              chapter: reader.novel.chapters[index],
              crawlerFactory: data,
            );
          },
          onPageChanged: (index) =>
              ref.read(readerProvider(reader).notifier).setCurrentIndex,
        ),
      ),
    );
  }
}
