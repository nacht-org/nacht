import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';

import '../models/models.dart';
import '../services/services.dart';

final historySessionProvider = StateNotifierProvider.autoDispose
    .family<HistorySessionNotifier, HistorySessionInfo, int>(
  (ref, id) => HistorySessionNotifier(
    ref: ref,
    state: const HistorySessionInfo(historyOrNull: null, isLoaded: false),
    createAndReturnHistory: ref.watch(createAndReturnHistoryProvider),
    updateHistory: ref.watch(updateHistoryProvider),
  ),
  name: "HistorySessionProvider",
);

class HistorySessionNotifier extends StateNotifier<HistorySessionInfo>
    with LoggerMixin {
  HistorySessionNotifier({
    required Ref ref,
    required HistorySessionInfo state,
    required CreateAndReturnHistory createAndReturnHistory,
    required UpdateHistory updateHistory,
  })  : _ref = ref,
        _createAndReturnHistory = createAndReturnHistory,
        _updateHistory = updateHistory,
        super(state);

  final Ref _ref;
  final CreateAndReturnHistory _createAndReturnHistory;
  final UpdateHistory _updateHistory;

  Future<void> record(NovelData novel, ChapterData chapter) async {
    final incognito = _ref.read(incognitoProvider);
    if (incognito) {
      log.fine("Incognito mode: skipped recording chapter in history");
      return;
    }

    if (state.isLoaded) {
      update(chapter);
    } else {
      init(novel, chapter);
    }
  }

  Future<void> init(NovelData novel, ChapterData chapter) async {
    final model = await _createAndReturnHistory.execute(novel.id, chapter.id);
    final history = HistoryData.fromModel(model, novel, chapter);

    state = state.copyWith(
      historyOrNull: history,
      isLoaded: true,
    );
  }

  Future<void> update(ChapterData chapter) async {
    state = state.copyWith(
      historyOrNull: state.history.copyWith(
        updatedAt: DateTime.now(),
        chapter: chapter,
      ),
    );

    await _updateHistory.execute(state.history.id, chapter.id);
  }
}
