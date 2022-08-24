import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

class BrowseSearchButton extends ConsumerWidget {
  const BrowseSearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.watch(browseSearchProvider.notifier);

    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
          onRemove: () => notifier.setActive(false),
        ));

        notifier.setActive(true);
      },
    );
  }
}
