import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/features/features.dart';

part 'update_entry.freezed.dart';

@freezed
class UpdateEntry with _$UpdateEntry {
  factory UpdateEntry.date(DateTime date) = UpdateEntryDate;
  factory UpdateEntry.chapter(NovelData novel, ChapterData pair) =
      UpdateEntryChapter;
}
