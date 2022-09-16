import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/history/providers/providers.dart';
import 'package:nacht/shared/shared.dart';

import '../services/services.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<HistoryData>>(
  (ref) => HistoryNotifier(
    read: ref.read,
    watchHistory: ref.watch(watchHistoryProvider),
    deleteHistory: ref.watch(deleteHistoryProvider),
    deleteNovelHistory: ref.watch(deleteNovelHistoryProvider),
  ),
);

class HistoryNotifier extends StateNotifier<List<HistoryData>> {
  HistoryNotifier({
    required Reader read,
    required WatchHistory watchHistory,
    required DeleteHistory deleteHistory,
    required DeleteNovelHistory deleteNovelHistory,
  })  : _read = read,
        _watchHistory = watchHistory,
        _deleteHistory = deleteHistory,
        _deleteNovelHistory = deleteNovelHistory,
        super(const []);

  final Reader _read;
  final WatchHistory _watchHistory;
  final DeleteHistory _deleteHistory;
  final DeleteNovelHistory _deleteNovelHistory;

  Future<void> init() async {
    final stream = _watchHistory.execute();
    stream.listen((data) => state = data);
  }

  Future<void> deleteHistory() async {
    final selected = _read(historySelectionProvider).selected;
    await _deleteHistory.execute(selected);
  }

  Future<void> deleteNovelHistory() async {
    final selected = _read(historySelectionProvider).selected;
    final novelIds = state
        .where((history) => selected.contains(history.id))
        .map((history) => history.novel.id);

    await _deleteNovelHistory.execute(novelIds);
  }
}
