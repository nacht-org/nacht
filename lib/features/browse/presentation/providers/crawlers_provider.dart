import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../../domain/domain.dart';
import '../presentation.dart';

final crawlersProvider = Provider<List<CrawlerListItem>>(
  (ref) {
    final filter =
        ref.watch(browsePreferencesProvider.select((value) => value.filter));
    final filterFunction = _createFilterFunction(filter);
    final crawlers =
        ref.watch(getCrawlersProvider).execute().where(filterFunction);

    final map = <String, List<CrawlerEntry>>{};
    for (final crawler in crawlers) {
      final entry = CrawlerEntry.from(crawler);
      map.putIfAbsent(entry.meta.lang, () => []).add(entry);
    }

    return _convert(map).toList();
  },
  name: 'CrawlersProvider',
);

bool Function(sources.CrawlerFactory) _createFilterFunction(int filter) {
  return (element) {
    if (BrowseFilter.unsupported.isHidden(filter) &&
        !element.meta().support.isPlatformSupported(currentPlatform())) {
      return false;
    }

    return true;
  };
}

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
