import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_info.freezed.dart';

@freezed
class ContentInfo with _$ContentInfo {
  const factory ContentInfo.loading() = _ContentLoading;
  factory ContentInfo.data(String content) = _ContentData;
}
