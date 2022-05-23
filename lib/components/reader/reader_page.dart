import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';
import 'provider/reader_intermediate_provider.dart';
import 'widgets/reader_view.dart';

class ReaderPage extends ConsumerWidget {
  const ReaderPage({
    Key? key,
    required this.novel,
    required this.chapter,
    required this.incomplete,
  }) : super(key: key);

  final NovelData novel;
  final ChapterData chapter;
  final bool incomplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (incomplete) {
      // retrieve the complete novel information from database
      final state = ref.watch(readerIntermediateProvider(novel));

      return state.when(
        loading: () => const Scaffold(),
        error: (error, stack) => Text('Error: $error'),
        data: (data) => ReaderView(novel: data, chapter: chapter),
      );
    } else {
      return ReaderView(novel: novel, chapter: chapter);
    }
  }
}
