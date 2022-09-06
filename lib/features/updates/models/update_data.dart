import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';

part 'update_data.freezed.dart';

@freezed
class UpdateData with _$UpdateData {
  factory UpdateData({
    required int id,
    required NovelData novel,
    required ChapterData chapter,
    required DateTime updatedAt,
  }) = _UpdateData;

  factory UpdateData.fromModel(
    Update model,
    NovelData novel,
    ChapterData chapter,
  ) {
    return UpdateData(
      id: model.id,
      novel: novel,
      chapter: chapter,
      updatedAt: model.updatedAt,
    );
  }

  UpdateData._();
}
