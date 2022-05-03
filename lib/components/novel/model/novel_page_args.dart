import 'package:chapturn/domain/entities/novel/novel_data.dart';
import 'package:chapturn/domain/entities/novel/partial_novel_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_page_args.freezed.dart';

@freezed
class NovelEntityArgument with _$NovelEntityArgument {
  factory NovelEntityArgument.partial(PartialNovelData novel) = _PartialEntity;
  factory NovelEntityArgument.complete(NovelData novel) = _CompleteEntity;
}
