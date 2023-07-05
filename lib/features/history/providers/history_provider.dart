import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/history/providers/providers.dart';
import 'package:nacht/shared/shared.dart';

import '../services/services.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<HistoryData>>(
  (ref) => HistoryNotifier(
    ref: ref,
    watchHistory: ref.watch(watchHistoryProvider),
    deleteHistory: ref.watch(deleteHistoryProvider),
    deleteNovelHistory: ref.watch(deleteNovelHistoryProvider),
    deleteAllHistory: ref.watch(deleteAllHistoryProvider),
  ),
);

class HistoryNotifier extends StateNotifier<List<HistoryData>> {
  HistoryNotifier({
    required Ref ref,
    required WatchHistory watchHistory,
    required DeleteHistory deleteHistory,
    required DeleteNovelHistory deleteNovelHistory,
    required DeleteAllHistory deleteAllHistory
  })  : _ref = ref,
        _watchHistory = watchHistory,
        _deleteHistory = deleteHistory,
        _deleteNovelHistory = deleteNovelHistory,
        _deleteAllHistory = deleteAllHistory,
        super(const []);

  final Ref _ref;
  final WatchHistory _watchHistory;
  final DeleteHistory _deleteHistory;
  final DeleteNovelHistory _deleteNovelHistory;
  final DeleteAllHistory _deleteAllHistory;

  Future<void> init() async {
    final stream = _watchHistory.execute();
    stream.listen((data) => state = data);
  }

  Future<void> deleteHistory() async {
    final selected = _ref.read(historySelectionProvider).selected;
    await _deleteHistory.execute(selected);
  }

  Future<void> deleteNovelHistory() async {
    final selected = _ref.read(historySelectionProvider).selected;
    final novelIds = state
        .where((history) => selected.contains(history.id))
        .map((history) => history.novel.id);

    await _deleteNovelHistory.execute(novelIds);
  }

  Future<void> deleteAllHistory() async {
     await _deleteAllHistory.call();
  }
}
