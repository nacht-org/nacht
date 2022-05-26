import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/domain/domain.dart';

part 'reader_info.freezed.dart';

@freezed
class ReaderInfo with _$ReaderInfo {
  factory ReaderInfo({
    required NovelData novel,
    required ChapterData initial,
    required List<ChapterData> chapters,
    required int? currentIndex,
  }) = _ReaderInfo;

  factory ReaderInfo.from(NovelData novel, ChapterData initial) {
    final chapters = novel.volumes
        .map((volume) => volume.chapters)
        .reduce((value, element) => [...value, ...element]);

    return ReaderInfo(
      novel: novel,
      initial: initial,
      chapters: chapters,
      currentIndex: null,
    );
  }

  ReaderInfo._();

  ChapterData get current =>
      currentIndex == null ? initial : chapters[currentIndex!];

  int get initialIndex => chapters.indexOf(initial);
}
