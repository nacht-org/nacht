import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_data.freezed.dart';

@freezed
class AssetData with _$AssetData {
  factory AssetData(
    List<int> data,
    String mimetype,
    String hash,
  ) = _AssetData;
}
