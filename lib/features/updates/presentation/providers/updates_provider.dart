import 'package:nacht/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

final updatesProvider =
    StateNotifierProvider<UpdatesNotifier, List<UpdateEntry>>(
  (ref) => UpdatesNotifier(
    state: [],
    watchUpdates: ref.watch(watchUpdatesProvider),
  ),
  name: 'UpdatesProvider',
);

class UpdatesNotifier extends StateNotifier<List<UpdateEntry>> {
  UpdatesNotifier({
    required List<UpdateEntry> state,
    required WatchUpdates watchUpdates,
  })  : _watchUpdates = watchUpdates,
        super(state);

  final WatchUpdates _watchUpdates;

  Future<void> initialize() async {
    _watchUpdates.execute().listen((data) {
      state = _map(data);
    });
  }

  List<UpdateEntry> _map(List<UpdateData> data) {
    final map = <DateTime, List<UpdateData>>{};

    for (final update in data) {
      final date = DateTime(
        update.updatedAt.year,
        update.updatedAt.month,
        update.updatedAt.day,
      );

      map.putIfAbsent(date, () => []).add(update);
    }

    final entries = <UpdateEntry>[];

    final sortedKeys = map.keys.toList()..sort();
    for (final date in sortedKeys.reversed) {
      entries.add(UpdateEntry.date(date));

      final updates = map[date]!;
      for (final update in updates) {
        entries.add(UpdateEntry.chapter(update.novel, update.chapter));
      }
    }

    return entries;
  }
}
