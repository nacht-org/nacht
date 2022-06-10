import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

import '../presentation.dart';

final currentEssentialProvider =
    Provider.autoDispose<NovelHead>((ref) => throw UnimplementedError());

class NovelHead extends ConsumerWidget {
  const NovelHead({
    Key? key,
    required this.head,
  }) : super(key: key);

  final HeadInfo head;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactory = ref.watch(crawlerFactoryFamily(head.url));
    final crawler = crawlerFactory != null
        ? ref.watch(crawlerFamily(crawlerFactory))
        : null;

    ImageProvider? image;
    if (head.cover != null) {
      image = FileImage(head.cover!.file);
    } else if (head.coverUrl != null) {
      image = NetworkImage(head.coverUrl!);
    } else {
      image = null;
    }

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
                child: image != null
                    ? Image(
                        image: image,
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    head.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    head.author ?? 'Unknown author',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  StatusInfo(
                    status: head.status,
                    suffix: crawler?.meta.name,
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
