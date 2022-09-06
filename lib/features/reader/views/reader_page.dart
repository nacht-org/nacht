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
        data: (data) => ReaderView(info: ReaderInfo.from(data, chapter)),
      );
    } else {
      return ReaderView(info: ReaderInfo.from(novel, chapter));
    }
  }
}
