import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
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
    return NachtListTile(
      leading: GestureDetector(
        onTap: () => context.router.push(
          NovelRoute(
            type: NovelType.novel(novel),
          ),
        ),
        child: novel.coverUrl != null
            ? SizedBox.square(
                dimension: 44,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: novel.coverUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : null,
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
