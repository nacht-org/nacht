import 'package:nacht_sources/nacht_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'crawler_family.freezed.dart';

final crawlerFamily = Provider.autoDispose.family<CrawlerInfo, CrawlerFactory>(
  (ref, crawlerFactory) {
    final meta = crawlerFactory.meta();
    final crawler = crawlerFactory.basic();

    return CrawlerInfo(meta: meta, instance: crawler);
  },
  name: 'CrawlerFactory',
);

@freezed
class CrawlerInfo with _$CrawlerInfo {
  factory CrawlerInfo({
    required Meta meta,
    required Crawler instance,
  }) = _CrawlerHolding;

  bool get isPopularSupported => meta.features.contains(Feature.popular);
  bool get isPopularNotSupported => !isPopularSupported;

  bool get isSearchSupported => meta.features.contains(Feature.search);
  bool get isSearchNotSupported => !isSearchSupported;

  CrawlerInfo._();
}
