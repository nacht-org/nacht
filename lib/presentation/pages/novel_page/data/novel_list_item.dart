import 'package:chapturn/domain/entities/novel/chapter_entity.dart';
import 'package:chapturn/domain/entities/novel/volume_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_list_item.freezed.dart';

@freezed
class NovelListItem with _$NovelListItem {
  factory NovelListItem.volume(VolumeEntity volume) = _VolumeListItem;
  factory NovelListItem.chapter(ChapterEntity chapter) = _ChapterListItem;
}
