import 'package:nacht/common/common.dart';
import 'package:nacht/features/browse/browse.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'popular_fetch_provider.dart';

final popularProvider = Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerFamily(crawlerFactory));
    if (info.isPopularNotSupported) {
      return const FetchState.unsupported("Popular not supported");
    }

    final fetch = ref.watch(popularFetchProvider(info));
    if (fetch.page == 1) {
      if (fetch.error != null) {
        return FetchState.error(fetch.error!);
      }

      return const FetchState.loading();
    }

    return FetchState.data(fetch.data);
  },
  name: 'PopularProvider',
);
