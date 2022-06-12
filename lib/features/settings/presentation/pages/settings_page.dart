import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: const Text('Settings'),
            floating: true,
            forceElevated: innerBoxIsScrolled,
          ),
        ],
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'Theme',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              _buildThemeModeTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeModeTile() {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref
            .watch(themePreferencesProvider.select((theme) => theme.themeMode));
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
      },
    );
  }
}
