import 'chapter_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume_entity.freezed.dart';

@freezed
class VolumeEntity with _$VolumeEntity {
  factory VolumeEntity({
    required int id,
    required int index,
    required String name,
    required List<ChapterEntity> chapters,
    required int novelId,
  }) = _VolumeEntity;
}
