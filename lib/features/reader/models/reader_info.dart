import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/features/features.dart';

part 'reader_info.freezed.dart';

@freezed
class ReaderInfo with _$ReaderInfo {
  factory ReaderInfo({
    required NovelData novel,
    required ChapterData initial,
    required int? currentIndex,
    required int initialIndex,
  }) = _ReaderInfo;

  int get index => currentIndex ?? initialIndex;

  ReaderInfo._();
}
