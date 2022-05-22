import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'crawler_provider.freezed.dart';

final crawlerProvider =
    Provider.autoDispose.family<CrawlerHolding, CrawlerFactory>(
  (ref, crawlerFactory) {
    final meta = crawlerFactory.meta();
    final crawler = crawlerFactory.basic();

    return CrawlerHolding(meta: meta, crawler: crawler);
  },
  name: 'CrawlerFactory',
);

@freezed
class CrawlerHolding with _$CrawlerHolding {
  factory CrawlerHolding({
    required Meta meta,
    required Crawler crawler,
  }) = _CrawlerHolding;
}