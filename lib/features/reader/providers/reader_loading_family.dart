import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

final readerLoadingFamily =
    FutureProvider.autoDispose.family<NovelData, NovelData>(
  (ref, data) async {
    final getNovelById = ref.watch(getNovelByIdProvider);

    final result = await getNovelById.execute(data.id);

    return result.fold(
      (failure) => throw failure,
      (data) => data,
    );
  },
  name: 'ReaderLoadingProvider',
);
