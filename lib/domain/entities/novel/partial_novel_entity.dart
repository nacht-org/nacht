import 'package:freezed_annotation/freezed_annotation.dart';

part 'partial_novel_entity.freezed.dart';

@freezed
class PartialNovelEntity with _$PartialNovelEntity {
  factory PartialNovelEntity({
    required String title,
    required String url,
    String? coverUrl,
    String? author,
  }) = _PartialNovelEntity;
}
