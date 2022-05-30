import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/head_info.dart';
import 'status.dart';

final currentEssentialProvider =
    Provider.autoDispose<NovelHead>((ref) => throw UnimplementedError());

class NovelHead extends StatelessWidget {
  const NovelHead({Key? key, required this.head}) : super(key: key);

  final HeadInfo head;

  @override
  Widget build(BuildContext context) {
    final ImageProvider? image = head.cover.fold(
      () => head.coverUrl.fold(
        () => null,
        (url) => NetworkImage(url),
      ),
      (cover) => FileImage(cover.file),
    );

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
                    maxLines: 3,
                  ),
                  Text(
                    head.author.toNullable() ?? 'Unknown',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,
                  ),
                  StatusInfo(
                    status: head.status,
                    suffix: head.meta.toNullable()?.name,
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
