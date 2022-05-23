import 'package:chapturn/domain/services/novel_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';

final readerIntermediateProvider =
    FutureProvider.autoDispose.family<NovelData, NovelData>(
  (ref, data) async {
    final novelService = ref.watch(novelServiceProvider);

    final result = await novelService.getById(data.id);

    return result.fold(
      (failure) => throw failure,
      (data) => data,
    );
  },
  name: 'ReaderIntermediateProvider',
);
