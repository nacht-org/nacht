import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('More'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ],
      body: DestinationTransition(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () => context.router.push(const CategoryRoute()),
            ),
            const Divider(),
            Consumer(builder: (context, ref, child) {
              final themeMode = ref.watch(
                  themePreferencesProvider.select((theme) => theme.themeMode));
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
                          .map((themeMode) =>
                              RadioItem(themeMode.name, themeMode))
                          .toList(),
                      value: themeMode,
                    ),
                  );

                  if (value != null) {
                    notifier.setThemeMode(value);
                  }
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
