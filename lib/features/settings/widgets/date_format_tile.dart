import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/dialogs/radio_dialog.dart';

class DateFormatTile extends ConsumerWidget {
  const DateFormatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pattern = ref
        .watch(dateFormatPreferencesProvider.select((value) => value.pattern));
    final notifier = ref.watch(dateFormatPreferencesProvider.notifier);

    final now = DateTime.now();

    return ListTile(
      title: const Text('Date format'),
      subtitle: Text(_label(pattern, now)),
      onTap: () async {
        final value = await showDialog<DateFormatPattern>(
          context: context,
          builder: (context) => RadioDialog(
            title: 'Date format',
            items: DateFormatPattern.values
                .map((item) => RadioItem(_label(item, now), item))
                .toList(),
            value: pattern,
          ),
        );

        if (value != null) {
          notifier.setPattern(value);
        }
      },
    );
  }

  String _label(DateFormatPattern dateFormatPattern, DateTime dateTime) {
    return '${dateFormatPattern.name} (${DateFormat(dateFormatPattern.pattern).format(dateTime)})';
  }
}
