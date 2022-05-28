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
          value: preferences.fontFamily.name,
          items: ReaderFontFamily.values
              .map((font) => MenuListTileItem(value: font, label: font.name))
              .toList(),
          itemText: (item) => item.name,
          onChanged: notifier.setFontFamily,
        ),
      ],
    );
  }
}
