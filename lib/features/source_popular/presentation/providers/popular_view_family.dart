import 'package:nacht/common/common.dart';
import 'package:nacht/features/source_search/source_search.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'popular_family.dart';

final popularViewFamily =
    Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final isSearching = ref.watch(isSearchingProvider);
    if (isSearching) {
      return ref.watch(searchProvider(crawlerFactory));
    } else {
      return ref.watch(popularFamily(crawlerFactory));
    }
  },
  name: 'PopularViewProvider',
);
