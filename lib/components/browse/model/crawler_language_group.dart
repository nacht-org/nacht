import 'package:freezed_annotation/freezed_annotation.dart';

import 'crawler_entry.dart';

part 'crawler_language_group.freezed.dart';

@freezed
class CrawlerLanguageGroup with _$CrawlerLanguageGroup {
  factory CrawlerLanguageGroup(
    String language,
    List<CrawlerEntry> entries,
  ) = _CrawlerLanguageGroup;
}
