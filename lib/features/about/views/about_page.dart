import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/widgets/loading_error.dart';

import '../providers/package_info_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: const Text('About'),
            floating: true,
            forceElevated: innerBoxIsScrolled,
          ),
        ],
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Consumer(builder: (context, ref, child) {
            final packageInfo = ref.watch(packageInfoProvider);

            return packageInfo.when(
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const LoadingError(
                message: Text('Unable to load package information'),
              ),
              data: (data) => buildView(context, data),
            );
          }),
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
