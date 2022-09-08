import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/logger/logger.dart';

import '../novel.dart';

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
}

class ChapterInput extends Equatable {
  const ChapterInput(this.data);

  final ChapterData data;

  @override
  List<Object?> get props => [data.id];
}
