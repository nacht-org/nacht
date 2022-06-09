import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/database/database.dart';

part 'category_data.freezed.dart';

@freezed
class CategoryData with _$CategoryData {
  factory CategoryData({
    required int id,
    required int index,
    required String name,
    required bool isDefault,
    required int novelCount,
  }) = _CategoryData;

  factory CategoryData.fromModel(
    NovelCategory category, {
    int novelCount = 0,
  }) {
    return CategoryData(
      id: category.id,
      index: category.categoryIndex,
      name: category.name,
      isDefault: category.id == NovelCategorySeed.defaultCategory,
      novelCount: novelCount,
    );
  }

  CategoryData._();
}
