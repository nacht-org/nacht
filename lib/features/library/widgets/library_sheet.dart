import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/library/preferences/display/library_display_mode.dart';
import 'package:nacht/features/library/preferences/display/library_display_preferences_provider.dart';
import 'package:nacht/widgets/widgets.dart';

class LibrarySheet extends StatelessWidget {
  const LibrarySheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) => const LibrarySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderTile(
            title: Text('Display mode'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 8.0,
              children: List.generate(
                LibraryDisplayMode.values.length,
                (index) {
                  final displayMode = LibraryDisplayMode.values[index];
                  return DisplayModeChip(displayMode: displayMode);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayModeChip extends ConsumerWidget {
  const DisplayModeChip({
    super.key,
    required this.displayMode,
  });

  final LibraryDisplayMode displayMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(libraryDisplayPreferencesProvider
        .select((value) => value.displayMode == displayMode));
    final notifier = ref.watch(libraryDisplayPreferencesProvider.notifier);

    return ChoiceChip(
      label: Text(displayMode.label),
      selected: selected,
      onSelected: (value) {
        if (value) notifier.setDisplayMode(displayMode);
      },
    );
  }
}
