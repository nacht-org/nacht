import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/entities.dart';

part 'novel_page_info.freezed.dart';

@freezed
class NovelPageInfo with _$NovelPageInfo {
  factory NovelPageInfo({
    required String title,
    required Option<String> coverUrl,
    required Option<AssetEntity> cover,
    required Option<String> author,
    required NovelStatus status,
    required Option<Meta> meta,
  }) = _NovelPageInfo;
}

@freezed
class NovelPageMore with _$NovelPageMore {
  factory NovelPageMore({
    required List<String> description,
    required List<String> tags,
  }) = _NovelPageMore;
}
