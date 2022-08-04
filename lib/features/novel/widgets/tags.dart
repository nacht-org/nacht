import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/tags_stream_family.dart';

class Tags extends ConsumerWidget {
  const Tags({
    Key? key,
    required this.novelId,
    required this.expanded,
  }) : super(key: key);

  final int novelId;
  final ValueNotifier<bool> expanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(tagsStreamFamily(novelId));

    final children = data.whenOrNull(
          data: (tags) => <Widget>[
            for (final tag in tags)
              Chip(
                label: Text(
                  tag.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
          ],
        ) ??
        [];

    if (children.isEmpty) {
      return const SizedBox.shrink();
    } else if (expanded.value) {
      return Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: children,
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: children
              .map((child) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: child,
                  ))
              .toList(),
        ),
      );
    }
  }
}
