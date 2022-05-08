import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

import '../../../domain/domain.dart';

final chapterCountProvider =
    Provider.autoDispose.family<int, NovelData>((ref, data) {
  return data.volumes.map((e) => e.chapters.length).sum;
});
