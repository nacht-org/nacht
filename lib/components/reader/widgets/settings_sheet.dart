import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/components.dart';
import 'package:nacht/core/core.dart';

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
        Consumer(builder: (context, ref, child) {
          final size = ref.watch(
              readerPreferencesProvider.select((reader) => reader.fontSize));

          return ListTile(
            title: const Text('Font size'),
            subtitle: Text('$size'),
            trailing: Row(children: [
              IconButton(
                onPressed: () => notifier.setFontSize(size - 1),
                icon: const Icon(Icons.remove),
              ),
              IconButton(
                onPressed: () => notifier.setFontSize(size + 1),
                icon: const Icon(Icons.add),
              ),
            ]),
          );
        })
      ],
    );
  }
}
