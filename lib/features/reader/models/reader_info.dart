import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/shared/shared.dart';

part 'reader_info.freezed.dart';

@freezed
class ReaderInfo with _$ReaderInfo {
  factory ReaderInfo({
    required NovelData novel,
    required ChapterData initial,
    required int? currentIndex,
    required int initialIndex,
  }) = _ReaderInfo;

  ReaderInfo._();
}
