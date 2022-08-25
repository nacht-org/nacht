import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

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
              const ThemeModeTile(),
              const Divider(),
              ListTile(
                title: Text(
                  'Timestamps',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const DateFormatTile(),
            ],
          ),
        ),
      ),
    );
  }
}
