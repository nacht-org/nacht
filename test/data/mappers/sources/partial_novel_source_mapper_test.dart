import 'package:chapturn/data/mappers/sources/partial_novel_source_mapper.dart';
import 'package:chapturn/domain/entities/partial_novel_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../mapper_helper.dart';

void main() {
  final mapFrom = PartialNovelSourceMapFrom();

  mapFromTest<PartialNovelEntity, Novel>(
    entity: PartialNovelEntity(
      title: 'novel_title',
      url: 'https://my.site.com/novel/123',
      author: 'erpson',
      thumbnailUrl: 'https://cdn.site.com/novel/cover.jpg',
    ),
    model: Novel(
      title: 'novel_title',
      url: 'https://my.site.com/novel/123',
      lang: 'en',
      thumbnailUrl: 'https://cdn.site.com/novel/cover.jpg',
      author: 'erpson',
    ),
    mapper: mapFrom,
  );
}
