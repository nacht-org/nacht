import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

    final title = release.name ?? 'New Release';
    final published = release.publishedAt == null
        ? null
        : dateFormatService.relativeDay(release.publishedAt!);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            if (published != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                child: Text(
                  "Published $published",
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            Markdown(
              data: release.body ?? "No description provided",
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
              FilledButton(
                onPressed: () {},
                child: const Text('Download'),
              ),
              if (release.htmlUrl != null)
                OutlinedButton(
                  onPressed: () => launchUrlString(
                    release.htmlUrl!,
                    mode: LaunchMode.externalNonBrowserApplication,
                  ),
                  child: const Text('Github'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
