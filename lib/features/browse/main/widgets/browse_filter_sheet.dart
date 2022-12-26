import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

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
        const ListTile(
          leading: Icon(Icons.filter_list),
          title: Text('Filter'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            children: List.generate(BrowseFilter.values.length, (index) {
              final bit = BrowseFilter.values[index];
              return Consumer(
                builder: (context, ref, child) {
                  final shown = ref.watch(browsePreferencesProvider
                      .select((value) => bit.isShown(value.filter)));

                  return FilterChip(
                    label: Text(bit.name),
                    selected: shown,
                    onSelected: (_) => notifier.toggleFilter(bit),
                  );
                },
              );
            }),
          ),
        )
      ],
    );
  }
}
