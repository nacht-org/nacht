import 'package:chapturn/components/library/provider/library_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/category/category_data.dart';

final relevantCategoriesProvider = Provider<List<CategoryData>>((ref) {
  final categories = ref.watch(libraryProvider);

  if (categories.length <= 1) {
    return categories;
  }

  if (categories.first.novels.isEmpty) {
    return categories.sublist(1);
  }

  return categories;
});

final tabCountProvider =
    Provider<int>((ref) => ref.watch(relevantCategoriesProvider).length);
