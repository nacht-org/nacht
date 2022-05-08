import 'package:chapturn/components/popular/provider/crawler_info_provider.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import 'popular_fetch_provider.dart';

part 'popular_provider.freezed.dart';

final popularProvider =
    Provider.autoDispose.family<PopularInfo, CrawlerFactory>(
  (ref, crawlerFactory) {
    final info = ref.watch(crawlerInfoProvider(crawlerFactory));
    if (info.popularParser == null) {
      return const PopularInfo.unsupported();
    }

    final fetch = ref.watch(popularFetchProvider(info));
    if (fetch.isInitial) {
      return const PopularInfo.loading();
    }

    return PopularInfo.data(fetch.data);
  },
  name: 'PopularProvider',
);

@freezed
class PopularInfo with _$PopularInfo {
  const factory PopularInfo.loading() = _PopularLoading;
  const factory PopularInfo.unsupported() = _PopularUnsupported;
  const factory PopularInfo.data(List<PartialNovelData> entities) =
      _PopularData;
}
