import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/shared/shared.dart';

part 'reader_page_info.freezed.dart';

@freezed
class ReaderPageInfo with _$ReaderPageInfo {
  factory ReaderPageInfo({
    required ChapterData chapter,
    required ContentInfo content,
    required CrawlerInfo crawler,
    required bool fetched,
  }) = _ReaderPageInfo;

  factory ReaderPageInfo.from(ChapterData data, CrawlerInfo crawler) {
    final ContentInfo content;
    content = const ContentInfo.loading();

    return ReaderPageInfo(
      chapter: data,
      content: content,
      crawler: crawler,
      fetched: false,
    );
  }

  ReaderPageInfo._();
}

@freezed
class ContentInfo with _$ContentInfo {
  const factory ContentInfo.loading() = _ContentLoading;
  const factory ContentInfo.data(String content) = _ContentData;
  const factory ContentInfo.error(String message) = _ContentError;
}
