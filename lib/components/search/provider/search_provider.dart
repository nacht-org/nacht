import 'package:chapturn/components/search/provider/search_fetch_provider.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/provider.dart';
import '../../browse/model/fetch_state.dart';

final searchProvider = Provider.autoDispose.family<FetchState, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerProvider(crawlerFactory));
    if (info.searchNotSupported) {
      return const FetchState.unsupported("Search not supported");
    }

    final fetch = ref.watch(searchFetchProvider(info));
    if (fetch.isInitial) {
      return const FetchState.empty();
    } else if (fetch.isInitialLoading) {
      return const FetchState.loading();
    }

    return FetchState.data(fetch.data);
  },
  name: 'SearchProvider',
);
