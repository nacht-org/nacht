import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/features/release/background_tasks/background_tasks.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:nacht/widgets/loading_error.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:nacht/core/constants.dart' as constants;

import '../providers/providers.dart';

@RoutePage()
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Consumer(
          builder: (context, ref, child) {
            final packageInfo = ref.watch(packageInfoProvider);

            return packageInfo.when(
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const LoadingError(
                message: Text('Unable to load package information'),
              ),
              data: (data) => buildView(context, data),
            );
          },
        ),
      ),
    );
  }

  ListView buildView(BuildContext context, PackageInfo data) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Version'),
          subtitle: Text('${data.version}+${data.buildNumber}'),
        ),
        Consumer(
          builder: (context, ref, child) {
            return ListTile(
              title: const Text("Check for updates"),
              onTap: () => ref.read(checkNewReleaseAndRouteProvider).call(),
            );
          },
        ),
        ListTile(
          title: const Text('Background update check'),
          onTap: () => AppUpdateCheckTask.id.registerOnce(),
        ),
        ListTile(
          title: const Text("What's new"),
          onTap: () => launchUrlString(
            "${constants.github}/releases/latest",
            mode: LaunchMode.externalNonBrowserApplication,
          ),
        ),
        ListTile(
          title: const Text('Licenses'),
          onTap: () => showLicensePage(
            context: context,
            applicationName: data.appName,
            applicationVersion: data.version,
          ),
        )
      ],
    );
  }
}
