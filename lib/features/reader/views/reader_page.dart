import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

@RoutePage()
class ReaderPage extends HookConsumerWidget {
  const ReaderPage({
    Key? key,
    required this.novel,
    required this.chapter,
  }) : super(key: key);

  final NovelData novel;
  final ChapterData chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapterListLoaded = ref.watch(
      chapterListFamily(novel.id).select((v) => v.isLoaded),
    );

    ref.watch(historySessionProvider(novel.id).notifier);

    useEffect(() {
      Future.wait([
        ref.read(chapterListFamily(novel.id).notifier).init(),
      ]);
      return null;
    }, []);

    return chapterListLoaded
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
