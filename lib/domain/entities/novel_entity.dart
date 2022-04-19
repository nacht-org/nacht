import 'package:chapturn/domain/entities/volume_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_entity.freezed.dart';

@freezed
class NovelEntity with _$NovelEntity {
  factory NovelEntity({
    required int? id,
    required String title,
    required String url,
    required String? author,
    required List<String> description,
    required String? thumbnailUrl,
    required NovelStatus status,
    required String lang,
    required List<VolumeEntity> volumes,
    required List<MetaData> metadata,
    required WorkType workType,
    required ReadingDirection readingDirection,
  }) = _NovelEntity;
}
