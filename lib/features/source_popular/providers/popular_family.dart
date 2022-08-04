import 'package:nacht/common/common.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'popular_fetch_family.dart';

final popularFamily = Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerFamily(crawlerFactory));
    if (!info.isSupported(Feature.popular)) {
      return const FetchState.unsupported("Popular not supported");
    }

    final fetch = ref.watch(popularFetchFamily(info));
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
