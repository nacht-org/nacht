import 'package:chapturn/components/browse/model/fetch_state.dart';
import 'package:chapturn/components/popular/provider/popular_provider.dart';
import 'package:chapturn/components/search/provider/is_searching_provider.dart';
import 'package:chapturn/components/search/provider/search_provider.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
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
