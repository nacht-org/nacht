import 'package:chapturn/domain/usecases/get_crawler_factory_for.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockCrawlerRepository mockCrawlerRepository;
  late GetCrawlerFactoryFor usecase;

  setUp(() {
    mockCrawlerRepository = MockCrawlerRepository();
    usecase = GetCrawlerFactoryFor(mockCrawlerRepository);
  });

  final testCrawlerFactory = crawlers.first;

  const tUrl = 'https://site.my/place/item';

  test('should get crawler factory from the repository', () async {
    when(mockCrawlerRepository.crawlerFactoryFor(tUrl))
        .thenAnswer((_) async => Right(testCrawlerFactory));

    final result = await usecase.execute(tUrl);

    expect(result, Right(testCrawlerFactory));
  });
}
