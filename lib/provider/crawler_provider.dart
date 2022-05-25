import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'crawler_provider.freezed.dart';

final crawlerProvider =
    Provider.autoDispose.family<CrawlerInfo, CrawlerFactory>(
  (ref, crawlerFactory) {
    final meta = crawlerFactory.meta();
    final crawler = crawlerFactory.basic();

    return CrawlerInfo(meta: meta, crawler: crawler);
  },
  name: 'CrawlerFactory',
);

@freezed
class CrawlerInfo with _$CrawlerInfo {
  factory CrawlerInfo({
    required Meta meta,
    required Crawler crawler,
  }) = _CrawlerHolding;

  bool get popularSupported => meta.features.contains(Feature.popular);
  bool get popularNotSupported => !popularSupported;

  bool get searchSupported => meta.features.contains(Feature.search);
  bool get searchNotSupported => !searchSupported;

  CrawlerInfo._();
}
