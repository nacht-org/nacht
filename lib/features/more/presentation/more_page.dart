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
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => context.router.push(const SettingsRoute()),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => context.router.push(const AboutRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
