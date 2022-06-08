import 'package:freezed_annotation/freezed_annotation.dart';

part 'browse_search_info.freezed.dart';

@freezed
class BrowseSearchInfo with _$BrowseSearchInfo {
  factory BrowseSearchInfo({
    required bool active,
  }) = _BrowseSearchInfo;

  BrowseSearchInfo._();
}
