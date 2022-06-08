import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/common/common.dart';

part 'update_entry.freezed.dart';

@freezed
class UpdateEntry with _$UpdateEntry {
  factory UpdateEntry.date(DateTime date) = _DateEntry;
  factory UpdateEntry.chapter(NovelData novel, ChapterData chapter) =
      _ChapterEntry;
}
