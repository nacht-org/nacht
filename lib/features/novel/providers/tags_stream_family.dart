import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';
import '../services/services.dart';

final tagsStreamFamily = StreamProvider.autoDispose
    .family<List<MetaEntryData>, int>((ref, id) async* {
  final watchTags = ref.watch(watchTagsProvider);
  yield* watchTags.execute(id);
});
