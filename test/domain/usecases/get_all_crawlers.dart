import 'package:chapturn/domain/usecases/get_all_crawlers.dart';
import 'package:chapturn/domain/usecases/get_crawler_factory_for.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockCrawlerRepository mockCrawlerRepository;
  late GetAllCrawlers usecase;

  setUp(() {
    mockCrawlerRepository = MockCrawlerRepository();
    usecase = GetAllCrawlers(mockCrawlerRepository);
  });

  final testCrawlers = crawlers;

  test('should get crawler factory from the repository', () async {
    when(mockCrawlerRepository.getAllCrawlers())
        .thenAnswer((_) async => Right(testCrawlers));

    final result = await usecase.execute();

    expect(result, Right(testCrawlers));
  });
}
