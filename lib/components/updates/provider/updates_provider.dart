import 'package:chapturn/domain/services/updates_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import '../model/update_entry.dart';

final updatesProvider =
    StateNotifierProvider<UpdatesNotifier, List<UpdateEntry>>(
  (ref) => UpdatesNotifier(
    state: [],
    updatesService: ref.watch(updatesServiceProvider),
    timeService: ref.watch(timeServiceProvider),
  ),
  name: 'UpdatesProvider',
);

class UpdatesNotifier extends StateNotifier<List<UpdateEntry>> {
  UpdatesNotifier({
    required List<UpdateEntry> state,
    required UpdatesService updatesService,
    required TimeService timeService,
  })  : _updatesService = updatesService,
        _timeService = timeService,
        super(state);

  final UpdatesService _updatesService;
  final TimeService _timeService;

  Future<void> fetch() async {
    final data = await _updatesService.getUpdates();
    state = _map(data);
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
      entries.add(UpdateEntry.date(_timeService.relativeDay(date)));

      final updates = map[date]!;
      for (final update in updates) {
        entries.add(UpdateEntry.chapter(update.novel, update.chapter));
      }
    }

    return entries;
  }
}
