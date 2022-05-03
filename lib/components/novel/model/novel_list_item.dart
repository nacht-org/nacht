import 'package:chapturn/domain/entities/novel/chapter_data.dart';
import 'package:chapturn/domain/entities/novel/volume_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_list_item.freezed.dart';

@freezed
class NovelListItem with _$NovelListItem {
  factory NovelListItem.volume(VolumeData volume) = _VolumeListItem;
  factory NovelListItem.chapter(ChapterData chapter) = _ChapterListItem;
}
