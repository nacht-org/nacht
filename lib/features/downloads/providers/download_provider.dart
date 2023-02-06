import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

part 'download_provider.freezed.dart';

@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState({
    required DownloadData? current,
    required bool isRunning,
  }) = _DownloadState;

  const DownloadState._();
}

final downloadProvider = StateNotifierProvider<DownloadNotifier, DownloadState>(
  (ref) => DownloadNotifier(
    const DownloadState(
      current: null,
      isRunning: false,
    ),
  ),
  name: 'DownloadProvider',
);

class DownloadNotifier extends StateNotifier<DownloadState> {
  DownloadNotifier(super.state);

  void setCurrent(DownloadData? current) {
    state = state.copyWith(current: current);
  }

  void setRunning(bool isRunning) {
    state = state.copyWith(isRunning: isRunning);
  }

  void stop() {
    state = state.copyWith(current: null, isRunning: false);
  }
}
