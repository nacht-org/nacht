import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class SettingsSheet extends ConsumerWidget {
  const SettingsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final preferences = ref.watch(readerPreferencesProvider);
    final notifier = ref.watch(readerPreferencesProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            'Reader settings',
            style: theme.textTheme.titleLarge,
          ),
        ),
        MenuListTile<ReaderFontFamily>(
          title: 'Font family',
          active: MenuListTileItem(
            value: preferences.fontFamily,
            label: preferences.fontFamily.name,
          ),
          items: ReaderFontFamily.values
              .map((font) => MenuListTileItem(value: font, label: font.name))
              .toList(),
          onChanged: notifier.setFontFamily,
        ),
        Consumer(
          builder: (context, ref, child) {
            final fontSize = ref.watch(
                readerPreferencesProvider.select((reader) => reader.fontSize));

            return StepListTile(
              title: const Text('Font size'),
              subtitle: Text('$fontSize'),
              value: fontSize,
              onChanged: notifier.setFontSize,
              min: 8.0,
              max: 22.0,
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final lineHeight = ref.watch(readerPreferencesProvider
                .select((reader) => reader.lineHeight));

            return StepListTile(
              title: const Text('Line height'),
              subtitle: Text('$lineHeight'),
              value: lineHeight,
              onChanged: notifier.setLineHeight,
              step: 0.1,
              min: 0.6,
              max: 2.2,
            );
          },
        )
      ],
    );
  }
}
