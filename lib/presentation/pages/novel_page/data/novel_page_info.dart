import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_page_info.freezed.dart';

@freezed
class NovelPageInfo with _$NovelPageInfo {
  factory NovelPageInfo({
    required String title,
    required Option<String> coverUrl,
    required Option<String> author,
    required Option<NovelStatus> status,
    required Option<Meta> meta,
  }) = _NovelPageInfo;
}
