import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class ThemeModeTile extends ConsumerWidget {
  const ThemeModeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themePreferencesProvider.select((theme) => theme.themeMode));
    final notifier = ref.watch(themePreferencesProvider.notifier);

    return ListTile(
      title: const Text('Theme mode'),
      subtitle: Text(themeMode.name),
      onTap: () async {
        final value = await showDialog<ThemeModePreference>(
          context: context,
          builder: (context) => RadioDialog(
            title: 'Theme mode',
            items: ThemeModePreference.values
                .map((themeMode) => RadioItem(themeMode.name, themeMode))
                .toList(),
            value: themeMode,
          ),
        );

        if (value != null) {
          notifier.setThemeMode(value);
        }
      },
    );
  }
}
