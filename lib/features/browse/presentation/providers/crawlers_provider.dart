import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

final crawlersProvider = Provider<List<CrawlerListItem>>((ref) {
  final crawlers = ref.watch(getCrawlersProvider).execute();

  final map = <String, List<CrawlerEntry>>{};
  for (final crawler in crawlers) {
    final entry = CrawlerEntry.from(crawler);
    map.putIfAbsent(entry.meta.lang, () => []).add(entry);
  }

  return _convert(map).toList();
});

Iterable<CrawlerListItem> _convert(
    Map<String, List<CrawlerEntry>> groups) sync* {
  final sortedGroups = groups.keys.toList()..sort();

  if (sortedGroups.remove('mixed')) {
    yield CrawlerListItem.language('mixed');

    final entries = groups['mixed']!;
    yield* _convertCrawlerList(entries);
  }

  for (final group in sortedGroups) {
    yield CrawlerListItem.language(group);

    final entries = groups[group]!;
    yield* _convertCrawlerList(entries);
  }
}

Iterable<CrawlerListItem> _convertCrawlerList(
    List<CrawlerEntry> entries) sync* {
  final sorted = entries..sort((a, b) => a.meta.name.compareTo(b.meta.name));
  yield* sorted.map((entry) => CrawlerListItem.crawler(entry));
}
