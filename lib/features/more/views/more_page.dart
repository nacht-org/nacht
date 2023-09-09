import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:flutter/material.dart';
import 'package:nacht/features/features.dart';

import '../widgets/widgets.dart';

class MorePage extends HookConsumerWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SafeArea(
          child: ListView(
            children: [
              const IncognitoTile(),
              const Divider(),
              const DownloadQueueTile(),
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
              const NavigationOffset(),
            ],
          ),
        ),
      ),
      extendBody: true,
    );
  }
}
