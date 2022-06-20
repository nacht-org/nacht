import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import 'settings_sheet.dart';

class ReaderBottomBar extends ConsumerWidget {
  const ReaderBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(readerPreferencesProvider.notifier);

    return CustomBottomBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final colorMode = ref.watch(
                  readerPreferencesProvider.select((value) => value.colorMode));

              return PopupMenuButton<ReaderColorMode>(
                tooltip: 'Color mode',
                initialValue: colorMode,
                itemBuilder: (context) => ReaderColorMode.values
                    .map(
                      (mode) =>
                          PopupMenuItem(value: mode, child: Text(mode.name)),
                    )
                    .toList(),
                onSelected: notifier.setColorMode,
                icon: const Icon(Icons.style),
              );
            },
          ),
          Consumer(builder: (context, ref, child) {
            final fontFamily = ref.watch(
                readerPreferencesProvider.select((value) => value.fontFamily));

            return PopupMenuButton<ReaderFontFamily>(
              tooltip: 'Font family',
              initialValue: fontFamily,
              itemBuilder: (context) => ReaderFontFamily.values
                  .map((font) =>
                      PopupMenuItem(value: font, child: Text(font.name)))
                  .toList(),
              onSelected: notifier.setFontFamily,
              icon: const Icon(Icons.font_download),
            );
          }),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => showExpandableBottomSheet(
              context: context,
              builder: (context, scrollController) => Material(
                child: SettingsSheet(
                  controller: scrollController,
                ),
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
