import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/core/preferences/browse/browse_preferences_provider.dart';

class BrowseFilterSheet extends ConsumerWidget {
  const BrowseFilterSheet({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(browsePreferencesProvider.notifier);

    return ListView.builder(
      controller: scrollController,
      itemCount: BrowseFilter.values.length,
      itemBuilder: (context, index) {
        final bit = BrowseFilter.values[index];

        return Consumer(
          builder: (context, ref, child) {
            final active = ref.watch(browsePreferencesProvider
                .select((value) => bit.isActive(value.filter)));

            return CheckboxListTile(
              value: !active,
              title: Text(bit.name),
              onChanged: (value) => notifier.toggleFilter(bit),
            );
          },
        );
      },
    );
  }
}
