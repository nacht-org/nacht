import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data.dart';
import '../novel/novel_data.dart';

part 'category_data.freezed.dart';

@freezed
class CategoryData with _$CategoryData {
  factory CategoryData({
    required int id,
    required int index,
    required String name,
    required bool isDefault,
    required List<NovelData> novels,
  }) = _CategoryData;

  factory CategoryData.fromModel(NovelCategory category) {
    return CategoryData(
      id: category.id,
      index: category.categoryIndex,
      name: category.name,
      isDefault: category.id == NovelCategorySeed.defaultCategory,
      novels: [],
    );
  }

  CategoryData._();
}
