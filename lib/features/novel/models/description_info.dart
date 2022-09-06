import 'package:freezed_annotation/freezed_annotation.dart';

part 'description_info.freezed.dart';

@freezed
class DescriptionInfo with _$DescriptionInfo {
  factory DescriptionInfo({
    required List<String> description,
    required List<String> tags,
  }) = _DescriptionInfo;
}
