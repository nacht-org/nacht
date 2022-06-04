import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/database/database.dart';

part 'volume_data.freezed.dart';

@freezed
class VolumeData with _$VolumeData {
  factory VolumeData({
    required int id,
    required int index,
    required String name,
    required int novelId,
  }) = _VolumeData;

  factory VolumeData.fromModel(Volume volume) {
    return VolumeData(
      id: volume.id,
      index: volume.volumeIndex,
      name: volume.name,
      novelId: volume.novelId,
    );
  }

  VolumeData._();
}
