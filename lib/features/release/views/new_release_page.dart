import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../background_tasks/background_tasks.dart';
import '../models/models.dart';
import '../services/services.dart';

@RoutePage()
class NewReleasePage extends ConsumerWidget {
  const NewReleasePage({
    super.key,
    required this.release,
  });

  final Release release;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final downloadAssets =
        ref.read(getPlatformDownloadAssetsProvider).call(release);

    return Scaffold(
      body: Scrollbar(
        child: ListView(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                child: Icon(
                  Icons.info_outline,
                  size: 48.0,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: Text(
                'New version available',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            if (release.tagName != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
                child: Text(
                  release.tagName!,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            Markdown(
              data: release.body ?? "No description",
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (downloadAssets != null)
                    FilledButton(
                      onPressed: () {
                        AppUpdateDownloadTask.id.registerOnce(
                          inputData: {
                            'release': jsonEncode(ReleaseWithDownloadAssets(
                              release: release,
                              downloadAssets: downloadAssets,
                            ).toJson()),
                          },
                        );
                        context.router.pop();
                      },
                      child: const Text('Download'),
                    )
                  else if (release.htmlUrl != null)
                    FilledButton(
                      onPressed: () => launchUrlString(
                        release.htmlUrl!,
                        mode: LaunchMode.externalNonBrowserApplication,
                      ),
                      child: const Text('GitHub'),
                    ),
                  OutlinedButton(
                    onPressed: () => context.router.pop(),
                    child: const Text('Not now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
