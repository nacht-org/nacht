import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';
import '../services/services.dart';

typedef FetchLocalMap = Map<String, FetchLocalInfo>;

final fetchLocalProvider =
    StateNotifierProvider.autoDispose<FetchLocalProvider, FetchLocalMap>(
  (ref) {
    var provider = FetchLocalProvider(
      getLocalForUrl: ref.watch(watchLocalForUrlProvider),
    );

    ref.onDispose(() => provider.cancel());

    return provider;
  },
  name: "GetLocalForUrlProvider",
);

class FetchLocalProvider extends StateNotifier<FetchLocalMap> {
  FetchLocalProvider({
    required WatchLocalForUrl getLocalForUrl,
  })  : _getLocalForUrl = getLocalForUrl,
        super({});

  final WatchLocalForUrl _getLocalForUrl;
  final List<StreamSubscription<FetchCardLocalInfo?>> subscriptions = [];

  Future<void> load(String url) async {
    final info = state[url];
    if (info == null || !info.fetched) {
      final stream = _getLocalForUrl.execute(url);
      final subscription = stream.listen((local) {
        state = {...state, url: FetchLocalInfo(fetched: true, local: local)};
      });

      subscriptions.add(subscription);
    }
  }

  void cancel() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
  }
}
