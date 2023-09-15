import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart';

import '../providers/providers.dart';

class SliverCrawlerList extends ConsumerWidget {
  const SliverCrawlerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlers = ref.watch(crawlersProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return crawlers[index].when(language: (language) {
            final lang =
                langFromCode(language)?['name'] ?? language.capitalize();

            return ListTile(
              title: Text(
                lang,
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }, crawler: (entry) {
            return ListTile(
              leading: CrawlerLogo(
                meta: entry.meta,
                isSupported: entry.isSupported,
              ),
              title: Text(entry.meta.name),
              subtitle: Text(entry.meta.version.version),
              onTap: () => context.router.push(
                PopularRoute(crawlerFactory: entry.factory),
              ),
              enabled: entry.isSupported,
            );
          });
        },
        childCount: crawlers.length,
      ),
    );
  }
}

class CrawlerLogo extends StatelessWidget {
  const CrawlerLogo({
    super.key,
    required this.meta,
    required this.isSupported,
  });

  final Meta meta;
  final bool isSupported;

  @override
  Widget build(BuildContext context) {
    Widget child = CachedNetworkImage(
      imageUrl: meta.logo.src,
      placeholder: (context, url) => DecoratedBox(
        decoration: BoxDecoration(
          color: Color(meta.logo.color),
        ),
      ),
      errorWidget: (context, url, error) => DecoratedBox(
        decoration: BoxDecoration(
          color: Color(meta.logo.color),
        ),
      ),
      fit: BoxFit.cover,
    );

    if (!isSupported) {
      child = ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.grey,
          BlendMode.saturation,
        ),
        child: child,
      );
    }

    return SizedBox.square(
      dimension: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: child,
      ),
    );
  }
}
