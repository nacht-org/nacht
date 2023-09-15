import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

import '../preferences/preferences.dart';

class SliverFetchDisplay extends ConsumerWidget {
  const SliverFetchDisplay({
    super.key,
    required this.novels,
    required this.crawler,
  });

  final List<PartialNovelData> novels;
  final CrawlerInfo crawler;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayMode = ref.watch(
        browseDisplayPreferencesProvider.select((value) => value.displayMode));

    return switch (displayMode) {
      BrowseDisplayMode.compactGrid =>
        SliverFetchGrid(novels: novels, crawler: crawler),
      BrowseDisplayMode.list =>
        SliverFetchList(novels: novels, crawler: crawler)
    };
  }
}
