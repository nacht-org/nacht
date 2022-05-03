import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'partial_novel_data.freezed.dart';

@freezed
class PartialNovelData with _$PartialNovelData {
  factory PartialNovelData({
    required String title,
    required String url,
    String? coverUrl,
    String? author,
  }) = _PartialNovelData;

  factory PartialNovelData.fromSource(sources.Novel novel) {
    return PartialNovelData(
      title: novel.title,
      url: novel.url,
      coverUrl: novel.thumbnailUrl,
      author: novel.author,
    );
  }

  PartialNovelData._();
}
