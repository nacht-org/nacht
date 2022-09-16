import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/shared/shared.dart';

part 'history_session_info.freezed.dart';

@freezed
class HistorySessionInfo with _$HistorySessionInfo {
  const factory HistorySessionInfo({
    required HistoryData? historyOrNull,
    required bool isLoaded,
  }) = _HistorySessionInfo;

  /// FIXME: remove null coercion as this in unsafe
  HistoryData get history => historyOrNull!;

  const HistorySessionInfo._();
}
