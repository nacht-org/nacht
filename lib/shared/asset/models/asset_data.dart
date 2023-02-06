import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/database/database.dart';

part 'asset_data.freezed.dart';

@freezed
class AssetData with _$AssetData {
  factory AssetData({
    required int id,
    required String? url,
    required File? file,
    required String hash,
    required String mimetype,
    required DateTime savedAt,
  }) = _AssetData;

  factory AssetData.fromModel(Asset asset) {
    return AssetData(
      id: asset.id,
      url: asset.url,
      file: asset.path != null ? File(asset.path!) : null,
      hash: asset.hash,
      mimetype: AssetTypeSeed.intoMimeType(asset.typeId),
      savedAt: asset.savedAt,
    );
  }

  AssetData._();
}
