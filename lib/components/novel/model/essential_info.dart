import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'essential_info.freezed.dart';

@freezed
class EssentialInfo with _$EssentialInfo {
  factory EssentialInfo({
    required String title,
    required Option<String> coverUrl,
    required Option<AssetData> cover,
    required Option<String> author,
    required NovelStatus status,
    required Option<Meta> meta,
  }) = _EssentialInfo;

  factory EssentialInfo.fromPartial(PartialNovelData novel) {
    return EssentialInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      cover: const None(),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: NovelStatus.unknown,
      meta: const None(),
    );
  }

  factory EssentialInfo.fromNovel(NovelData novel) {
    return EssentialInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      cover: novel.cover == null ? const None() : Some(novel.cover!),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: novel.status,
      meta: const None(),
    );
  }

  EssentialInfo._();
}
