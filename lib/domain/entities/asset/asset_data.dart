import 'dart:io';

import 'package:chapturn/data/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data.dart';

part 'asset_data.freezed.dart';

@freezed
class AssetData with _$AssetData {
  factory AssetData({
    required int id,
    required String? url,
    required File file,
    required String hash,
    required String mimetype,
  }) = _AssetData;

  factory AssetData.fromModel(Asset asset) {
    return AssetData(
      id: asset.id,
      url: asset.url,
      file: File(asset.path!),
      hash: asset.hash,
      mimetype: AssetTypeSeed.intoMimeType(asset.typeId),
    );
  }

  AssetData._();
}
