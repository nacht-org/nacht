import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/components.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/domain/domain.dart';
import 'package:nacht/provider/provider.dart';

class ChapterUpdateTile extends ConsumerWidget {
  const ChapterUpdateTile({
    super.key,
    required this.novel,
    required ChapterData chapter,
  }) : _chapter = chapter;

  final NovelData novel;
  final ChapterData _chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapter = ref.watch(chapterProvider(ChapterInput(_chapter)));

    return NachtListTile(
      leading: GestureDetector(
        onTap: () => context.router.push(
          NovelRoute(
            type: NovelEither.complete(novel),
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
        chapter.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        context.router.push(
          ReaderRoute(
            novel: novel,
            chapter: chapter,
            doFetch: true,
          ),
        );
      },
      muted: chapter.readAt != null,
    );
  }
}
