import 'package:nacht/shared/shared.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'head_info.freezed.dart';

@freezed
class HeadInfo with _$HeadInfo {
  factory HeadInfo({
    required String title,
    required String url,
    required String? coverUrl,
    required AssetData? cover,
    required String? author,
    required sources.NovelStatus status,
  }) = _HeadInfo;

  factory HeadInfo.fromPartial(PartialNovelData novel) {
    return HeadInfo(
      title: novel.title,
      url: novel.url,
      coverUrl: novel.coverUrl,
      cover: null,
      author: novel.author,
      status: sources.NovelStatus.unknown,
    );
  }

  factory HeadInfo.fromNovel(NovelData novel) {
    return HeadInfo(
      title: novel.title,
      url: novel.url,
      coverUrl: novel.coverUrl,
      cover: novel.cover,
      author: novel.author,
      status: novel.status,
    );
  }

  HeadInfo._();
}
