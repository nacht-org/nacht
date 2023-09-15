import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../models/models.dart';

const _size = 40.0;

class NovelAvatar extends StatelessWidget {
  const NovelAvatar({
    Key? key,
    required this.novel,
    this.desaturate = false,
  }) : super(key: key);

  final NovelType novel;
  final bool desaturate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final title = novel.title;
    final coverUrl = novel.coverUrl;

    return GestureDetector(
      onTap: () => context.router.push(
        NovelRoute(type: novel),
      ),
      child: coverUrl != null
          ? SizedBox.square(
              dimension: _size,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Desaturate(
                  enabled: desaturate,
                  child: CachedNetworkImage(
                    imageUrl: coverUrl,
                    fit: BoxFit.cover,
                  ),
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
                title.isEmpty ? "@" : title[0],
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
