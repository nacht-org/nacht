import 'package:freezed_annotation/freezed_annotation.dart';

part 'toolbar_info.freezed.dart';

@freezed
class ToolbarInfo with _$ToolbarInfo {
  factory ToolbarInfo({
    required bool visible,
  }) = _ToolbarInfo;
}
