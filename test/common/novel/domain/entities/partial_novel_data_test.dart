import 'package:nacht/shared/shared.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSource = sources.Novel(
    title: 'novel_title',
    url: 'https://my.site.com/novel/123',
    lang: 'en',
    thumbnailUrl: 'https://cdn.site.com/novel/cover.jpg',
    author: 'erpson',
  );

  final tData = PartialNovelData(
    title: 'novel_title',
    url: 'https://my.site.com/novel/123',
    author: 'erpson',
    coverUrl: 'https://cdn.site.com/novel/cover.jpg',
  );

  test('should create PartialNovelData from sources.Novel', () {
    final result = PartialNovelData.fromSource(tSource);
    expect(result, tData);
  });
}
