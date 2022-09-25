import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_local_info.freezed.dart';

@freezed
class FetchLocalInfo with _$FetchLocalInfo {
  const factory FetchLocalInfo({
    required bool favourite,
  }) = _FetchLocalInfo;
}
