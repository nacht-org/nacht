import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';

part 'download_data.freezed.dart';

@freezed
class DownloadData with _$DownloadData {
  const factory DownloadData({
    required int id,
    required int orderIndex,
    required ChapterData chapter,
    required DateTime createdAt,
  }) = _DownloadData;

  factory DownloadData.fromModel(Download model, ChapterData chapter) {
    return DownloadData(
      id: model.id,
      orderIndex: model.orderIndex,
      chapter: chapter,
      createdAt: model.createdAt,
    );
  }

  const DownloadData._();
}
