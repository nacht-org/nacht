import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

part 'browse_search_info.freezed.dart';

@freezed
class BrowseSearchInfo with _$BrowseSearchInfo {
  factory BrowseSearchInfo({
    required bool active,
    required String query,
    required SearchResult result,
  }) = _BrowseSearchInfo;

  BrowseSearchInfo._();
}

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult.none() = _NoneResult;
  const factory SearchResult.http(sources.CrawlerFactory crawlerFactory) =
      _HttpResult;
  const factory SearchResult.error(String message) = _ErrorResult;
}
