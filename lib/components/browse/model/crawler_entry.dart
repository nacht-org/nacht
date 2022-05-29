import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht_sources/nacht_sources.dart';

part 'crawler_entry.freezed.dart';

@freezed
class CrawlerEntry with _$CrawlerEntry {
  factory CrawlerEntry({
    required Meta meta,
    required CrawlerFactory factory,
    required bool isSupported,
  }) = _CrawlerEntry;

  factory CrawlerEntry.from(CrawlerFactory factory) {
    return CrawlerEntry(
      meta: factory.meta(),
      factory: factory,
      isSupported: true,
    );
  }

  CrawlerEntry._();
}
