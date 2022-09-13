import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class RelativeTimestampsTile extends ConsumerWidget {
  const RelativeTimestampsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(dateFormatPreferencesProvider.notifier);
    final relative = ref.watch(
      dateFormatPreferencesProvider.select((pref) => pref.relative),
    );

    return ListTile(
      title: const Text("Relative timestamps"),
      subtitle: Text(relative.name),
      onTap: () async {
        final choice = await showDialog(
          context: context,
          builder: (context) => RadioDialog(
            title: "Relative timestamps",
            items: RelativeTimestamp.values
                .map((e) => RadioItem(e.name, e))
                .toList(),
            value: relative,
          ),
        );

        if (choice != null) {
          notifier.setRelativeTimestamp(choice);
        }
      },
    );
  }
}
