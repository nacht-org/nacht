import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_entity.freezed.dart';

@freezed
class ChapterEntity with _$ChapterEntity {
  factory ChapterEntity({
    required int? id,
    required int index,
    required String title,
    required String? content,
    required String url,
    required DateTime? updated,
    required int? volumeId,
  }) = _ChapterEntity;
}
