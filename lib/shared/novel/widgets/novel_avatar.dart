import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';

const _size = 40.0;

class NovelAvatar extends StatelessWidget {
  const NovelAvatar({
    Key? key,
    required this.novel,
  }) : super(key: key);

  final NovelData novel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.router.push(
        NovelRoute(
          type: NovelType.novel(novel),
        ),
      ),
      child: novel.coverUrl != null
          ? SizedBox.square(
              dimension: _size,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  imageUrl: novel.coverUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              height: _size,
              width: _size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: theme.colorScheme.secondary.withAlpha(150),
              ),
              alignment: Alignment.center,
              child: Text(
                novel.title.isEmpty ? "@" : novel.title[0],
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
