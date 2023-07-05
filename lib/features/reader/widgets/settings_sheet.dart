import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class SettingsSheet extends ConsumerWidget {
  const SettingsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalNotifier = ref.watch(readerPreferencesProvider.notifier);
    final verticalNotifier =
        ref.watch(verticalReaderPreferencesProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderTile(
            title: Text('General'),
          ),
          Consumer(
            builder: (context, ref, child) {
              final colorMode = ref.watch(readerPreferencesProvider
                  .select((reader) => reader.colorMode));

              return MenuListTile<ReaderColorMode>(
                title: 'Color mode',
                active: MenuListTileItem(
                  value: colorMode,
                  label: colorMode.name,
                ),
                items: ReaderColorMode.values
                    .map((mode) =>
                        MenuListTileItem(value: mode, label: mode.name))
                    .toList(),
                onChanged: generalNotifier.setColorMode,
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final fontFamily = ref.watch(readerPreferencesProvider
                  .select((reader) => reader.fontFamily));

              return MenuListTile<ReaderFontFamily>(
                title: 'Font family',
                active: MenuListTileItem(
                  value: fontFamily,
                  label: fontFamily.name,
                ),
                items: ReaderFontFamily.values
                    .map((font) =>
                        MenuListTileItem(value: font, label: font.name))
                    .toList(),
                onChanged: generalNotifier.setFontFamily,
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final fontSize = ref.watch(readerPreferencesProvider
                  .select((reader) => reader.fontSize));

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
          const Divider(),
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
      ),
    );
  }
}
