import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/shared/shared.dart';

import 'models.dart';

part 'history_entry.freezed.dart';

@freezed
class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry.date(DateTime dateTime) = _HistoryDate;
  const factory HistoryEntry.history(HistoryData history) = _HistoryData;
}
