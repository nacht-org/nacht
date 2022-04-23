import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

class SourceToPartialNovelMapper extends Mapper<Novel, PartialNovelEntity> {
  @override
  PartialNovelEntity map(Novel input) {
    return PartialNovelEntity(
      title: input.title,
      url: input.url,
      thumbnailUrl: input.thumbnailUrl,
      author: input.author,
    );
  }
}
