import 'package:nacht/components/browse/model/fetch_state.dart';
import 'package:nacht/components/browse/search/search.dart';
import 'package:nacht/provider/crawler_provider.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchProvider = Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerProvider(crawlerFactory));
    if (info.searchNotSupported) {
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
