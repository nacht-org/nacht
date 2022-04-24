import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/entities/novel/partial_novel_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_page_args.freezed.dart';

@freezed
class NovelEntityArgument with _$NovelEntityArgument {
  factory NovelEntityArgument.partial(PartialNovelEntity novel) =
      _PartialEntity;
  factory NovelEntityArgument.complete(NovelEntity novel) = _CompleteEntity;
}
