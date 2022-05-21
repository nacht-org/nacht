import 'package:chapturn/components/reader/model/novel_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';

final readerNovelProvider = Provider.autoDispose.family<NovelInfo, NovelData>(
  (ref, data) => NovelInfo.fromNovelData(data),
  name: 'ReaderNovelProvider',
);
