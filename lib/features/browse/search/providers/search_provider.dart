import 'package:nacht/features/features.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final searchProvider = Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerFamily(crawlerFactory));
    if (!info.isSupported(Feature.search)) {
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
