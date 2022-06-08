import 'package:freezed_annotation/freezed_annotation.dart';

import 'crawler_entry.dart';

part 'crawler_list_item.freezed.dart';

@freezed
class CrawlerListItem with _$CrawlerListItem {
  factory CrawlerListItem.language(String language) = _LanguageItem;
  factory CrawlerListItem.crawler(CrawlerEntry entry) = _CrawlerItem;
}
