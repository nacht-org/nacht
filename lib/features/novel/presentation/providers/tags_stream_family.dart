import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/features/novel/domain/services/watch_tags.dart';

final tagsStreamFamily = StreamProvider.autoDispose
    .family<List<MetaEntryData>, int>((ref, id) async* {
  final watchTags = ref.watch(watchTagsProvider);
  yield* watchTags.execute(id);
});
