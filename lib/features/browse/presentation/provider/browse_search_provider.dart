import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/browse_search_info.dart';

final browseSearchProvider =
    StateNotifierProvider<BrowseSearchNotifier, BrowseSearchInfo>(
  (ref) => BrowseSearchNotifier(BrowseSearchInfo(active: false)),
  name: 'BrowseSearchProvider',
);

class BrowseSearchNotifier extends StateNotifier<BrowseSearchInfo> {
  BrowseSearchNotifier(super.state);

  void setActive(bool value) {
    state = state.copyWith(active: value);
  }
}
