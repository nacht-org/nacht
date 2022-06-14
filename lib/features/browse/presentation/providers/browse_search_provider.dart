import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

final browseSearchProvider =
    StateNotifierProvider<BrowseSearchNotifier, BrowseSearchInfo>(
  (ref) => BrowseSearchNotifier(
    state: BrowseSearchInfo(
      active: false,
      query: '',
      result: const SearchResult.none(),
    ),
    getCrawlerForUrl: ref.watch(getCrawlerForUrlProvider),
  ),
  name: 'BrowseSearchProvider',
);

class BrowseSearchNotifier extends StateNotifier<BrowseSearchInfo> {
  BrowseSearchNotifier({
    required BrowseSearchInfo state,
    required GetCrawlerForUrl getCrawlerForUrl,
  })  : _getCrawlerForUrl = getCrawlerForUrl,
        super(state);

  final GetCrawlerForUrl _getCrawlerForUrl;

  void setActive(bool value) {
    state = state.copyWith(active: value);
  }

  void search(String query) {
    query = query.trim();
    if (query.isEmpty || state.query == query) {
      return;
    }

    state = state.copyWith(query: query);

    if (query.startsWith(RegExp(r'https?'))) {
      if (isUriValid(query)) {
        _findSupported();
        return;
      }

      state = state.copyWith(
        result: const SearchResult.error("The url is not valid"),
      );
    } else {
      state = state.copyWith(
        result: const SearchResult.error("Coming soon"),
      );
    }
  }

  void _findSupported() {
    final crawlerFactory = _getCrawlerForUrl.execute(state.query);
    if (crawlerFactory != null) {
      state = state.copyWith(
        result: SearchResult.http(crawlerFactory),
      );
    } else {
      state = state.copyWith(
        result: const SearchResult.error("No supported crawler found"),
      );
    }
  }
}
