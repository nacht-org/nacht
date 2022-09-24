import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_local_info.freezed.dart';

@freezed
class FetchLocalInfo with _$FetchLocalInfo {
  const factory FetchLocalInfo({
    required bool fetched,
    required FetchCardLocalInfo? local,
  }) = _FetchLocalInfo;

  static bool favorite(FetchLocalInfo? info) => info?.local?.favorite ?? false;

  const FetchLocalInfo._();
}

@freezed
class FetchCardLocalInfo with _$FetchCardLocalInfo {
  const factory FetchCardLocalInfo({
    required bool favorite,
  }) = _FetchCardLocalInfo;
}
