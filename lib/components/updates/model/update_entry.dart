import 'package:chapturn/domain/entities/novel/chapter_data.dart';
import 'package:chapturn/domain/entities/novel/novel_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_entry.freezed.dart';

@freezed
class UpdateEntry with _$UpdateEntry {
  factory UpdateEntry.date(String date) = _DateEntry;
  factory UpdateEntry.chapter(NovelData novel, ChapterData chapter) =
      _ChapterEntry;
}
