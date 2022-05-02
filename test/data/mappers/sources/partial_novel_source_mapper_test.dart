import 'package:chapturn/data/mapper/mapper.dart';
import 'package:chapturn/domain/entities/novel/partial_novel_entity.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../mapper_helper.dart';

void main() {
  final mapper = SourceToPartialNovelMapper();

  mapperTest<Novel, PartialNovelEntity>(
    'source novel',
    'partial novel',
    from: Novel(
      title: 'novel_title',
      url: 'https://my.site.com/novel/123',
      lang: 'en',
      thumbnailUrl: 'https://cdn.site.com/novel/cover.jpg',
      author: 'erpson',
    ),
    to: PartialNovelEntity(
      title: 'novel_title',
      url: 'https://my.site.com/novel/123',
      author: 'erpson',
      coverUrl: 'https://cdn.site.com/novel/cover.jpg',
    ),
    mapper: mapper,
  );
}
