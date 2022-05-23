import 'package:chapturn/components/browse/model/fetch_state.dart';
import 'package:chapturn/provider/provider.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'popular_fetch_provider.dart';

final popularProvider = Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerProvider(crawlerFactory));
    if (info.popularNotSupported) {
      return const FetchState.unsupported("Popular not supported");
    }

    final fetch = ref.watch(popularFetchProvider(info));
    if (fetch.page == 1) {
      return const FetchState.loading();
    }

    return FetchState.data(fetch.data);
  },
  name: 'PopularProvider',
);
