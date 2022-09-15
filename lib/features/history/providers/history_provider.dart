import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../services/services.dart';

final historyProvider = StreamProvider<List<HistoryData>>((ref) async* {
  yield* ref.watch(watchHistoryProvider).execute();
});
