import 'package:nacht/shared/shared.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../browse.dart';

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
