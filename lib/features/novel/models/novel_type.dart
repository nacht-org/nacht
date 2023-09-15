import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'novel_type.freezed.dart';

@freezed
class NovelType with _$NovelType {
  factory NovelType.url(String url) = _UrlData;
  factory NovelType.partial(PartialNovelData partial) = _PartialData;
  factory NovelType.novel(NovelData novel) = _CompleteData;

  String get url {
    return when(
      url: (url) => url,
      partial: (partial) => partial.url,
      novel: (novel) => novel.url,
    );
  }

  String get title {
    return when(
      url: (_) => '',
      partial: (novel) => novel.title,
      novel: (novel) => novel.title,
    );
  }

  String? get coverUrl {
    return when(
      url: (_) => null,
      partial: (novel) => novel.coverUrl,
      novel: (novel) => novel.coverUrl,
    );
  }

  NovelType._();
}
