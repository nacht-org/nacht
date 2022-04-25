import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  factory CategoryEntity({
    required int id,
    required String name,
    required bool isDefault,
  }) = _CategoryEntity;
}
