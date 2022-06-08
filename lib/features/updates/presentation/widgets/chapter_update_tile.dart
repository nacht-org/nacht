import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/provider/provider.dart';
import 'package:nacht/widgets/widgets.dart';

class ChapterUpdateTile extends ConsumerWidget {
  const ChapterUpdateTile({
    super.key,
    required this.novel,
    required this.chapter,
  });

  final NovelData novel;
  final ChapterData chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(chapterProvider(ChapterInput(chapter)));

    return NachtListTile(
      leading: GestureDetector(
        onTap: () => context.router.push(
          NovelRoute(
            type: NovelType.complete(novel),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              novel.coverUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        novel.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        context.router.push(
          ReaderRoute(
            novel: novel,
            chapter: data,
            doFetch: true,
          ),
        );
      },
      muted: data.readAt != null,
    );
  }
}
