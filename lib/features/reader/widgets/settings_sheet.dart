import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class SettingsSheet extends ConsumerWidget {
  const SettingsSheet({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(readerPreferencesProvider);
    final generalNotifier = ref.watch(readerPreferencesProvider.notifier);
    final verticalNotifier =
        ref.watch(verticalReaderPreferencesProvider.notifier);

    return ListView(
      controller: controller,
      children: [
        const HeaderTile(
          title: Text('General'),
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
          onChanged: generalNotifier.setFontFamily,
        ),
        Consumer(
          builder: (context, ref, child) {
            final fontSize = ref.watch(
                readerPreferencesProvider.select((reader) => reader.fontSize));

            return StepListTile(
              title: const Text('Font size'),
              subtitle: Text('$fontSize'),
              value: fontSize,
              onChanged: generalNotifier.setFontSize,
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
              onChanged: generalNotifier.setLineHeight,
              step: 0.1,
              min: 0.6,
              max: 2.2,
            );
          },
        ),
        const HeaderTile(
          title: Text('Vertical'),
        ),
        Consumer(
          builder: (context, ref, child) {
            final showScrollbar = ref.watch(
              verticalReaderPreferencesProvider
                  .select((value) => value.showScrollbar),
            );

            return SwitchListTile(
              title: const Text('Show scroll bar'),
              value: showScrollbar,
              onChanged: verticalNotifier.setShowScrollbar,
            );
          },
        ),
      ],
    );
  }
}
