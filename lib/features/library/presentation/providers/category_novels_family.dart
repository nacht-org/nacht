import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

import '../../domain/domain.dart';

final categoryNovelsFamily =
    StreamProvider.autoDispose.family<List<NovelData>, int>((ref, categoryId) {
  final streamCategoryNovels = ref.watch(watchCategoryNovelsProvider);
  return streamCategoryNovels.execute(categoryId);
});
