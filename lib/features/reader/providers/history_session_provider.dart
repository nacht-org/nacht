import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../services/services.dart';

final historySessionProvider = StateNotifierProvider.autoDispose
    .family<HistorySessionNotifier, HistorySessionInfo, int>(
  (ref, id) => HistorySessionNotifier(
    state: const HistorySessionInfo(historyOrNull: null, isLoaded: false),
    createAndReturnHistory: ref.watch(createAndReturnHistoryProvider),
    updateHistory: ref.watch(updateHistoryProvider),
  ),
  name: "HistorySessionProvider",
);

class HistorySessionNotifier extends StateNotifier<HistorySessionInfo> {
  HistorySessionNotifier({
    required HistorySessionInfo state,
    required CreateAndReturnHistory createAndReturnHistory,
    required UpdateHistory updateHistory,
  })  : _createAndReturnHistory = createAndReturnHistory,
        _updateHistory = updateHistory,
        super(state);

  final CreateAndReturnHistory _createAndReturnHistory;
  final UpdateHistory _updateHistory;

  Future<void> init(NovelData novel, ChapterData chapter) async {
    final model = await _createAndReturnHistory.execute(chapter.id);
    final history = HistoryData.fromModel(model, novel, chapter);

    state = state.copyWith(
      historyOrNull: history,
      isLoaded: true,
    );
  }

  Future<void> update(ChapterData chapter) async {
    if (!state.isLoaded) {
      return;
    }

    state = state.copyWith(
      historyOrNull: state.history.copyWith(
        updatedAt: DateTime.now(),
        chapter: chapter,
      ),
    );

    await _updateHistory.execute(state.history.id, chapter.id);
  }
}
