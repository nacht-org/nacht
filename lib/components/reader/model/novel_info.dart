import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'novel_info.freezed.dart';

@freezed
class NovelInfo with _$NovelInfo {
  factory NovelInfo({
    required NovelData data,
    required List<ChapterData> chapters,
  }) = _NovelInfo;

  factory NovelInfo.fromNovelData(NovelData data) {
    final chapters = data.volumes
        .map((volume) => volume.chapters)
        .reduce((value, element) => [...value, ...element]);

    return NovelInfo(
      data: data,
      chapters: chapters,
    );
  }

  NovelInfo._();
}
