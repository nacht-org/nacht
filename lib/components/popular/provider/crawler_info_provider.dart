import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'crawler_info_provider.freezed.dart';

final crawlerInfoProvider =
    Provider.autoDispose.family<CrawlerInfo, CrawlerFactory>(
  (ref, crawlerFactory) => CrawlerInfo.fromFactory(crawlerFactory),
  name: 'CrawlerInfoProvider',
);

@freezed
class CrawlerInfo with _$CrawlerInfo {
  factory CrawlerInfo({
    required Meta meta,
    required ParsePopular? popularParser,
  }) = _CrawlerInfo;

  factory CrawlerInfo.fromFactory(CrawlerFactory crawlerFactory) {
    final meta = crawlerFactory.meta();

    return CrawlerInfo(
      meta: meta,
      popularParser: meta.features.contains(Feature.popular)
          ? crawlerFactory.create() as ParsePopular
          : null,
    );
  }

  CrawlerInfo._();
}
