import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/reader_info.dart';

final readerFamily = StateNotifierProvider.autoDispose
    .family<ReaderNotifier, ReaderInfo, ReaderInfo>(
  (ref, info) => ReaderNotifier(state: info),
  name: 'ReaderProvider',
);

class ReaderNotifier extends StateNotifier<ReaderInfo> {
  ReaderNotifier({required ReaderInfo state}) : super(state);

  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
