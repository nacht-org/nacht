import 'package:nacht/domain/domain.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late CrawlerRepository mockCrawlerRepository;
  late SourceService service;

  setUp(() {
    mockCrawlerRepository = MockCrawlerRepository();
    service = SourceService(crawlerRepository: mockCrawlerRepository);
  });

  group('crawlerFactoryFor', () {
    final testCrawlerFactory = crawlers.first;

    const tUrl = 'https://site.my/place/item';

    test('should get crawler factory from the repository', () {
      when(mockCrawlerRepository.crawlerFactoryFor(tUrl))
          .thenAnswer((_) => Some(testCrawlerFactory));

      final result = service.crawlerFactoryFor(url: tUrl);

      expect(result, Some(testCrawlerFactory));
    });
  });

  group('crawlers', () {
    const testCrawlers = crawlers;

    test('should get crawler factory from the repository', () async {
      when(mockCrawlerRepository.getAllCrawlers())
          .thenAnswer((_) => const Right(testCrawlers));

      final result = service.crawlers();

      expect(result, const Right(testCrawlers));
    });
  });

  group('popular', () {
    final tParser = MockParsePopular();
    const tPage = 1;
    final tNovels = [
      PartialNovelData(
        title: 'novel_title',
        url: 'https://my.site.com/novel/123',
        author: 'erpson',
        coverUrl: 'https://cdn.site.com/novel/cover.jpg',
      ),
    ];

    test('should get novels from crawler repository', () async {
      when(mockCrawlerRepository.getPopularNovels(tParser, tPage))
          .thenAnswer((_) async => Right(tNovels));

      final result = await service.popular(tParser, tPage);

      expect(result, Right(tNovels));
    });
  });
}
