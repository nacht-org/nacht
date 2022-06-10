import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/common/common.dart';

part 'reader_info.freezed.dart';

@freezed
class ReaderInfo with _$ReaderInfo {
  factory ReaderInfo({
    required NovelData novel,
    required ChapterData initial,
    required int? currentIndex,
  }) = _ReaderInfo;

  factory ReaderInfo.from(NovelData novel, ChapterData initial) {
    return ReaderInfo(
      novel: novel,
      initial: initial,
      currentIndex: null,
    );
  }

  ReaderInfo._();

  ChapterData get current =>
      currentIndex == null ? initial : novel.chapters[currentIndex!];

  int get initialIndex => novel.chapters.indexOf(initial);
}
