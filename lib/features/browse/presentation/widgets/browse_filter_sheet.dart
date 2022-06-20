import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class BrowseFilterSheet extends ConsumerWidget {
  const BrowseFilterSheet({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(browsePreferencesProvider.notifier);

    return ListView(
      controller: scrollController,
      children: [
        const HeaderTile(
          title: Text('Filter'),
        ),
        for (final bit in BrowseFilter.values)
          Consumer(
            builder: (context, ref, child) {
              final shown = ref.watch(browsePreferencesProvider
                  .select((value) => bit.isShown(value.filter)));

              return CheckboxListTile(
                value: shown,
                title: Text(bit.name),
                onChanged: (value) => notifier.toggleFilter(bit),
              );
            },
          ),
      ],
    );
  }
}
