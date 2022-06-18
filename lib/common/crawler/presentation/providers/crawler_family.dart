import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'crawler_family.freezed.dart';

final crawlerFamily =
    Provider.autoDispose.family<CrawlerInfo, sources.CrawlerFactory>(
  (ref, factory) {
    final meta = factory.meta();
    final handler = sources.IsolateHandler(factory: factory);

    ref.onDispose(() => handler.close());

    return CrawlerInfo(meta: meta, handler: handler);
  },
  name: 'CrawlerFactory',
);

@freezed
class CrawlerInfo with _$CrawlerInfo {
  factory CrawlerInfo({
    required sources.Meta meta,
    required sources.IsolateHandler handler,
  }) = _CrawlerHolding;

  bool isSupported(sources.Feature feature) => meta.features.contains(feature);

  CrawlerInfo._();
}
