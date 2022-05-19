import 'package:chapturn/domain/entities/novel/chapter_data.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../provider/provider.dart';
import 'content_info.dart';

part 'chapter_info.freezed.dart';

@freezed
class ChapterInfo with _$ChapterInfo {
  factory ChapterInfo({
    required ChapterData data,
    required ContentInfo content,
    required CrawlerHolding crawlerHolding,
    required bool fetched,
  }) = _ChapterInfo;

  factory ChapterInfo.fromChapterData(
    ChapterData data,
    CrawlerHolding crawlerHolding,
  ) {
    final ContentInfo content;
    if (data.content == null) {
      content = const ContentInfo.loading();
    } else {
      content = ContentInfo.data(data.content!);
    }

    return ChapterInfo(
      data: data,
      content: content,
      crawlerHolding: crawlerHolding,
      fetched: false,
    );
  }

  ChapterInfo._();
}
