import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/logger/logger.dart';

final chapterFamily = StateNotifierProvider.autoDispose
    .family<ChapterNotifier, ChapterData, ChapterInput>(
  (ref, input) => ChapterNotifier(
    state: input.data,
    setReadAt: ref.watch(setReadAtProvider),
  ),
  name: 'ChapterProvider',
);

class ChapterNotifier extends StateNotifier<ChapterData> with LoggerMixin {
  ChapterNotifier({
    required ChapterData state,
    required SetReadAt setReadAt,
  })  : _setReadAt = setReadAt,
        super(state);

  final SetReadAt _setReadAt;

  set readAt(DateTime? dateTime) {
    state = state.copyWith(readAt: dateTime);
  }

  Future<void> markAsRead() async {
    // Limit readAt updates to once every 5 minutes
    if (state.readAt != null &&
        DateTime.now().difference(state.readAt!).inMinutes < 5) {
      return;
    }

    log.fine('updating read at to now');

    final oldReadAt = state.readAt;
    state = state.copyWith(readAt: DateTime.now());

    final failure = await _setReadAt.execute([state], true);
    if (failure != null) {
      log.warning(failure);
      state = state.copyWith(readAt: oldReadAt);
    }
  }
}

class ChapterInput extends Equatable {
  const ChapterInput(this.data);

  final ChapterData data;

  @override
  List<Object?> get props => [data.id];
}
