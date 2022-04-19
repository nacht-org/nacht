import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/usecases/get_popular_novels.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockCrawlerRepository mockCrawlerRepository;
  late GetPopularNovels usecase;

  setUp(() {
    mockCrawlerRepository = MockCrawlerRepository();
    usecase = GetPopularNovels(crawlerRepository: mockCrawlerRepository);
  });

  final tParser = MockNovelPopular();
  final tPage = 1;
  final tNovels = [
    PartialNovelEntity(
      title: 'novel_title',
      url: 'https://my.site.com/novel/123',
      author: 'erpson',
      thumbnailUrl: 'https://cdn.site.com/novel/cover.jpg',
    ),
  ];

  test('should get novels from crawler repository', () async {
    when(mockCrawlerRepository.getPopularNovels(tParser, tPage))
        .thenAnswer((_) async => Right(tNovels));

    final result = await usecase.execute(tParser, tPage);

    expect(result, Right(tNovels));
  });
}
