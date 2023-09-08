import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/features/features.dart';

part 'history_data.freezed.dart';

@freezed
class HistoryData with _$HistoryData {
  const factory HistoryData({
    required int id,
    required DateTime addedAt,
    required DateTime updatedAt,
    required NovelData novel,
    required ChapterData chapter,
  }) = _HistoryData;

  factory HistoryData.fromModel(
    ReadingHistory model,
    NovelData novel,
    ChapterData chapter,
  ) {
    return HistoryData(
      id: model.id,
      addedAt: model.addedAt,
      updatedAt: model.updatedAt,
      novel: novel,
      chapter: chapter,
    );
  }

  const HistoryData._();
}
