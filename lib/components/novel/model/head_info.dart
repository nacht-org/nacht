import 'package:nacht_sources/nacht_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'head_info.freezed.dart';

@freezed
class HeadInfo with _$HeadInfo {
  factory HeadInfo({
    required String title,
    required Option<String> coverUrl,
    required Option<AssetData> cover,
    required Option<String> author,
    required NovelStatus status,
    required Option<Meta> meta,
  }) = _HeadInfo;

  factory HeadInfo.fromPartial(PartialNovelData novel, Meta? meta) {
    return HeadInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      cover: const None(),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: NovelStatus.unknown,
      meta: const None(),
    );
  }

  factory HeadInfo.fromNovel(NovelData novel, Meta? meta) {
    return HeadInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      cover: novel.cover == null ? const None() : Some(novel.cover!),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: novel.status,
      meta: const None(),
    );
  }

  HeadInfo._();
}
