import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

import 'novel_provider.dart';

final chapterCountProvider = Provider.autoDispose<int>(
  (ref) {
    final data = ref.watch(novelProvider);
    return data.volumes.map((e) => e.chapters.length).sum;
  },
  dependencies: [novelProvider],
  name: 'ChapterCountProvider',
);
