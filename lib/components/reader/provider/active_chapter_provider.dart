import 'package:chapturn/components/reader/model/novel_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';

final activeIndexProvider = StateProvider.autoDispose<int?>(
  (ref) => null,
  name: 'ActiveIndexProvider',
);

final activeChapterProvider =
    Provider.autoDispose.family<ChapterData?, NovelInfo>(
  (ref, info) {
    final index = ref.watch(activeIndexProvider);
    return index == null ? null : info.chapters[index];
  },
  name: 'ActiveChapterProvider',
);
