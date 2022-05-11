import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/essential_info.dart';
import 'status.dart';

final currentEssentialProvider =
    Provider.autoDispose<EssentialInfo>((ref) => throw UnimplementedError());

class EssentialSection extends ConsumerWidget {
  const EssentialSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(currentEssentialProvider);

    final image = info.cover.fold(
      () => info.coverUrl.fold(
        () => null,
        (url) => Image.network(url),
      ),
      (cover) => Image.file(cover.file),
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
                child: image,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  StatusInfo(
                    status: info.status,
                    suffix: info.meta.toNullable()?.name,
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