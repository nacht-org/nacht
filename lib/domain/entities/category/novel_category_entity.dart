import 'package:chapturn/domain/entities/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_category_entity.freezed.dart';

@freezed
class NovelCategoryEntity with _$NovelCategoryEntity {
  factory NovelCategoryEntity(
    CategoryEntity category,
    List<NovelEntity> novels,
  ) = _NovelCategoryEntity;
}
