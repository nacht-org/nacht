import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/providers.dart';

class SearchButton extends ConsumerWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(isSearchingProvider.notifier);

    return IconButton(
      onPressed: () {
        ModalRoute.of(context)!.addLocalHistoryEntry(
          LocalHistoryEntry(onRemove: () {
            notifier.state = false;
          }),
        );

        notifier.state = true;
      },
      icon: const Icon(Icons.search),
    );
  }
}
