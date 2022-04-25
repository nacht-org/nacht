import 'package:chapturn/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/providers.dart';

class NovelInfo extends ConsumerWidget {
  const NovelInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(novelInfoProvider);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 170,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: info.coverUrl.fold(
                  () => null,
                  (url) => Image.network(
                    url,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 3,
                  ),
                  Text(
                    info.author.toNullable() ?? 'Unknown',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.done_all, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(
                        info.status.fold(
                              () => 'Unknown',
                              (status) => status.name.capitalize(),
                            ) +
                            info.meta.fold(
                              () => '',
                              (meta) => ' • ${meta.name}',
                            ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
