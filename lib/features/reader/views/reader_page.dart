import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/reader/providers/history_session_provider.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class ReaderPage extends HookConsumerWidget {
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
    final chapterListLoaded = ref.watch(
      chapterListFamily(novel.id).select((v) => v.isLoaded),
    );

    final historySessionLoaded = ref.watch(
      historySessionProvider(novel.id).select((h) => h.isLoaded),
    );

    useEffect(() {
      Future.wait([
        ref.read(chapterListFamily(novel.id).notifier).init(),
        ref
            .read(historySessionProvider(novel.id).notifier)
            .init(novel, chapter),
      ]);
      return null;
    }, []);

    return chapterListLoaded && historySessionLoaded
        ? ReaderView(
            info: ReaderInfo(
              novel: novel,
              initial: chapter,
              currentIndex: null,
              initialIndex: ref
                  .read(chapterListFamily(novel.id))
                  .chapters
                  .indexOf(chapter),
            ),
          )
        : Container(); // TODO
  }
}
