import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_info.freezed.dart';

@freezed
class AssetInfo with _$AssetInfo {
  factory AssetInfo(
    List<int> bytes,
    String mimetype,
    String hash,
  ) = _AssetInfo;
}
