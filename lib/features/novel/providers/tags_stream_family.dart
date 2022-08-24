import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../services/watch_tags.dart';

final tagsStreamFamily = StreamProvider.autoDispose
    .family<List<MetaEntryData>, int>((ref, id) async* {
  final watchTags = ref.watch(watchTagsProvider);
  yield* watchTags.execute(id);
});
