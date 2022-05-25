import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';
import '../../../provider/provider.dart';
import 'content_info.dart';

part 'chapter_info.freezed.dart';

@freezed
class ChapterInfo with _$ChapterInfo {
  factory ChapterInfo({
    required NovelData novel,
    required ChapterData data,
    required ContentInfo content,
    required CrawlerInfo crawlerInfo,
    required bool fetched,
  }) = _ChapterInfo;

  factory ChapterInfo.fromChapterData(
    ChapterData data,
    NovelData novel,
    CrawlerInfo crawlerInfo,
  ) {
    final ContentInfo content;
    if (data.content == null) {
      content = const ContentInfo.loading();
    } else {
      content = ContentInfo.data(data.content!);
    }

    return ChapterInfo(
      data: data,
      novel: novel,
      content: content,
      crawlerInfo: crawlerInfo,
      fetched: false,
    );
  }

  ChapterInfo._();
}
