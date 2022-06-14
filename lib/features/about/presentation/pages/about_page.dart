import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation.dart';

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
          child: ListView(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final info = ref.watch(packageInfoProvider);

                  final version = info.when(
                    data: (data) => '${data.version}+${data.buildNumber}',
                    error: (error, stack) => 'Error',
                    loading: () => '',
                  );

                  return ListTile(
                    title: const Text('Version'),
                    subtitle: Text(version),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
