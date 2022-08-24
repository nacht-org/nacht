import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../services/watch_category_novels.dart';

final categoryNovelsFamily =
    StreamProvider.autoDispose.family<List<NovelData>, int>((ref, categoryId) {
  final streamCategoryNovels = ref.watch(watchCategoryNovelsProvider);
  return streamCategoryNovels.execute(categoryId);
});
