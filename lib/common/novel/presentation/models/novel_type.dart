import 'package:nacht/common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_type.freezed.dart';

@freezed
class NovelType with _$NovelType {
  factory NovelType.partial(PartialNovelData novel) = _PartialData;
  factory NovelType.complete(NovelData novel) = _CompleteData;

  String get url {
    return when(
      partial: (partial) => partial.url,
      complete: (novel) => novel.url,
    );
  }

  NovelType._();
}
