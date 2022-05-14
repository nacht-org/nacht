import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/category/category_data.dart';

part 'category_view_provider.freezed.dart';

@freezed
class CategoryViewData with _$CategoryViewData {
  const factory CategoryViewData.loading() = _LoadingData;
  const factory CategoryViewData.loaded(List<CategoryData> categories) =
      _LoadedData;
  const factory CategoryViewData.select(List<CategoryData> categories) =
      _SelectData;
}
