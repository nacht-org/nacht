import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../services/services.dart';

final historyProvider = StreamProvider<List<HistoryEntry>>((ref) async* {
  final stream = ref.watch(watchHistoryProvider).execute();
  yield* stream.map(_map);
});

List<HistoryEntry> _map(List<HistoryData> histories) {
  final map = <DateTime, List<HistoryData>>{};
  for (final history in histories) {
    final date = DateTime(
      history.updatedAt.year,
      history.updatedAt.month,
      history.updatedAt.day,
    );

    map.putIfAbsent(date, () => []).add(history);
  }

  final entries = <HistoryEntry>[];

  final sortedKeys = map.keys.toList()..sort();
  for (final date in sortedKeys.reversed) {
    entries.add(HistoryEntry.date(date));

    final histories = map[date]!;
    for (final history in histories) {
      entries.add(HistoryEntry.history(history));
    }
  }

  return entries;
}
