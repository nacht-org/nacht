import 'package:nacht/common/common.dart';
import 'package:nacht/features/browse/browse.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'search_fetch_provider.dart';

final searchProvider = Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerFamily(crawlerFactory));
    if (info.isSearchNotSupported) {
      return const FetchState.unsupported("Search not supported");
    }

    final fetch = ref.watch(searchFetchProvider(info));
    if (fetch.page == 1) {
      if (fetch.isLoading) {
        return const FetchState.loading();
      } else if (fetch.error != null) {
        return FetchState.error(fetch.error!);
      } else {
        return const FetchState.empty();
      }
    }

    return FetchState.data(fetch.data);
  },
  name: 'SearchProvider',
);
