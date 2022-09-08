import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class ReaderPage extends ConsumerWidget {
  const ReaderPage({
    Key? key,
    required this.novel,
    required this.chapter,
    required this.doFetch,
  }) : super(key: key);

  final NovelData novel;
  final ChapterData chapter;
  final bool doFetch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (doFetch) {
      // retrieve the complete novel information from database
      final state = ref.watch(readerLoadingFamily(novel));

      return state.when(
        loading: () => const Scaffold(),
        error: (error, stack) => Text('Error: $error'),
        data: (data) => ChapterListShell(
          id: novel.id,
          child: ReaderView(
            info: ReaderInfo(
              novel: data,
              initial: chapter,
              currentIndex: null,
              initialIndex: initialIndex(ref),
            ),
          ),
        ),
      );
    } else {
      return ChapterListShell(
        id: novel.id,
        child: ReaderView(
          info: ReaderInfo(
            novel: novel,
            initial: chapter,
            currentIndex: null,
            initialIndex: initialIndex(ref),
          ),
        ),
      );
    }
  }

  int initialIndex(WidgetRef ref) =>
      ref.read(chapterListFamily(novel.id)).chapters.indexOf(chapter);
}
