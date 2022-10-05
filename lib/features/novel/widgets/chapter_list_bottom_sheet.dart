import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

class ChapterListBottomSheet extends ConsumerWidget {
  const ChapterListBottomSheet({Key? key, required this.controller})
      : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(chapterListPreferencesProvider.notifier);
    const wrapPadding = EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0);

    return ListView(
      controller: controller,
      children: [
        const ListTile(
          leading: Icon(Icons.sort),
          title: Text("Sort"),
        ),
        Padding(
          padding: wrapPadding,
          child: Consumer(
            builder: (context, ref, child) {
              final sort = ref.watch(
                  chapterListPreferencesProvider.select((pref) => pref.sort));

              return Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: List.generate(
                  SortPreference.values.length,
                  (index) {
                    final current = SortPreference.values[index];
                    return ChoiceChip(
                      label: Text(current.name),
                      onSelected: (_) => notifier.setSort(current),
                      selected: current == sort,
                    );
                  },
                ),
              );
            },
          ),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.compare_arrows),
          title: Text("Order"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer(
            builder: (context, ref, child) {
              final order = ref.watch(
                  chapterListPreferencesProvider.select((pref) => pref.order));

              return Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: List.generate(OrderPreference.values.length, (index) {
                  final current = OrderPreference.values[index];
                  return ChoiceChip(
                    label: Text(current.name),
                    onSelected: (_) => notifier.setOrder(current),
                    selected: current == order,
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
