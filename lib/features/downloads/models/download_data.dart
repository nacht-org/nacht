import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';

part 'download_data.freezed.dart';

@freezed
class DownloadData with _$DownloadData {
  const factory DownloadData({
    required int id,
    required int orderIndex,
    required DownloadRelatedData related,
    required DateTime createdAt,
  }) = _DownloadData;

  factory DownloadData.fromModel(Download model, DownloadRelatedData related) {
    return DownloadData(
      id: model.id,
      orderIndex: model.orderIndex,
      related: related,
      createdAt: model.createdAt,
    );
  }

  const DownloadData._();
}

@freezed
class DownloadRelatedData with _$DownloadRelatedData {
  const factory DownloadRelatedData({
    required int novelId,
    required String novelTitle,
    required String novelUrl,
    required int chapterId,
    required String chapterTitle,
    required String chapterUrl,
    required int volumeId,
  }) = _DownloadRelatedData;

  factory DownloadRelatedData.from(NovelData novel, ChapterData chapter) {
    return DownloadRelatedData(
      novelId: novel.id,
      novelTitle: novel.title,
      novelUrl: novel.url,
      chapterId: chapter.id,
      chapterTitle: chapter.title,
      chapterUrl: chapter.url,
      volumeId: chapter.volume.id,
    );
  }

  const DownloadRelatedData._();
}
