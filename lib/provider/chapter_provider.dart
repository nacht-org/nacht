import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/logger/logger.dart';
import 'package:nacht/domain/domain.dart';

final chapterProvider = StateNotifierProvider.autoDispose
    .family<ChapterNotifier, ChapterData, ChapterInput>(
  (ref, input) => ChapterNotifier(
    state: input.data,
    chapterService: ref.watch(chapterServiceProvider),
  ),
  name: 'ChapterProvider',
);

class ChapterNotifier extends StateNotifier<ChapterData> with LoggerMixin {
  ChapterNotifier({
    required ChapterData state,
    required ChapterService chapterService,
  })  : _chapterService = chapterService,
        super(state);

  final ChapterService _chapterService;

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

    final result = await _chapterService.setReadAt([state], true);

    result.fold(
      (failure) {
        log.warning(failure);
        state = state.copyWith(readAt: oldReadAt);
      },
      (_) {},
    );
  }
}

class ChapterInput extends Equatable {
  const ChapterInput(this.data);

  final ChapterData data;

  @override
  List<Object?> get props => [data.id];
}
