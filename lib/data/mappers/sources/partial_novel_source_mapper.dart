import 'package:chapturn/data/mappers/mapper.dart';
import 'package:chapturn/domain/entities/partial_novel_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

class PartialNovelSourceMapFrom extends MapFrom<PartialNovelEntity, Novel> {
  @override
  PartialNovelEntity mapFrom(Novel model) {
    return PartialNovelEntity(
      title: model.title,
      url: model.url,
      thumbnailUrl: model.thumbnailUrl,
      author: model.author,
    );
  }
}
