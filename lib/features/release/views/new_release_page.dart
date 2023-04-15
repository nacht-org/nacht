import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:workmanager/workmanager.dart';

import '../background_tasks/background_tasks.dart';
import '../models/models.dart';
import '../notifications/notifications.dart';
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
    final locale = Localizations.localeOf(context);
    final dateFormatService = ref.watch(dateFormatServiceFamily(locale));

    final publishedAt = release.publishedAt == null
        ? null
        : dateFormatService.relativeDay(release.publishedAt!);

    final downloadAssets =
        ref.read(getPlatformDownloadAssetsProvider).call(release);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Update"),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            if (release.name != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                child: Text(
                  release.name!,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            if (publishedAt != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                child: Text(
                  "Published $publishedAt",
                  style: const TextStyle(fontStyle: FontStyle.italic),
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
        color: theme.colorScheme.surface,
        surfaceTintColor: theme.colorScheme.surfaceTint,
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (downloadAssets != null)
                FilledButton(
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      'update-download',
                      AppUpdateDownloadTask.name,
                      tag: BackgroundTaskTag.appUpdate,
                      inputData: {
                        'release': jsonEncode(ReleaseWithDownloadAssets(
                          release: release,
                          downloadAssets: downloadAssets,
                        ).toJson()),
                      },
                    );
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
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
