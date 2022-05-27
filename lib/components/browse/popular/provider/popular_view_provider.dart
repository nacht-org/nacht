import 'package:nacht/components/browse/model/fetch_state.dart';
import 'package:nacht/components/browse/popular/provider/popular_provider.dart';
import 'package:nacht/components/browse/search/search.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final popularViewProvider =
    Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final isSearching = ref.watch(isSearchingProvider);
    if (isSearching) {
      return ref.watch(searchProvider(crawlerFactory));
    } else {
      return ref.watch(popularProvider(crawlerFactory));
    }
  },
  name: 'PopularViewProvider',
);
