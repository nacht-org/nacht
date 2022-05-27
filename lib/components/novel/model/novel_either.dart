import 'package:nacht/domain/entities/novel/novel_data.dart';
import 'package:nacht/domain/entities/novel/partial_novel_data.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_either.freezed.dart';

@freezed
class NovelEither with _$NovelEither {
  factory NovelEither.partial(PartialNovelData novel, Crawler crawler) =
      _PartialData;
  factory NovelEither.complete(NovelData novel) = _CompleteData;
}
