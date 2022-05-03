import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:chapturn/domain/usecases/novel/parse_or_get_novel.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GatewayRepository mockRemoteRepository;
  late NovelRepository mockLocalRepository;
  late NetworkRepository mockNetworkRepository;
  late ParseOrGetNovel usecase;

  setUp(() {
    mockRemoteRepository = MockNovelRemoteRepository();
    mockLocalRepository = MockNovelLocalRepository();
    mockNetworkRepository = MockNetworkRepository();
    usecase = ParseOrGetNovel(
      remoteRepository: mockRemoteRepository,
      localRepository: mockLocalRepository,
      networkRepository: mockNetworkRepository,
    );
  });

  final tParser = MockParseNovel();
  const tId = 1;
  const tUrl = 'https://website.com/novel/123';

  final tNovel = Novel(
    title: 'My novel story',
    url: tUrl,
    lang: 'en',
  );

  final tNovelEntity = NovelData(
    id: tId,
    title: 'My novel story',
    url: tUrl,
    author: 'My',
    description: [],
    coverUrl: 'https://assets.website.com/novel/123/cover.jpg',
    status: NovelStatus.unknown,
    lang: 'en',
    volumes: [],
    metadata: [],
    workType: const OriginalWork(),
    readingDirection: ReadingDirection.ltr,
    favourite: false,
  );

  test(
    'should return from local repository when connection is unavailable',
    () async {
      when(mockNetworkRepository.isConnectionAvailable())
          .thenAnswer((_) async => false);
      when(mockLocalRepository.getNovelByUrl(tUrl))
          .thenAnswer((_) async => Right(tNovelEntity));

      final result = await usecase.execute(tParser, tUrl);

      expect(result, Right(tNovelEntity));
    },
  );

  test(
    'should update local novel entry when connection is available',
    () async {
      when(mockNetworkRepository.isConnectionAvailable())
          .thenAnswer((_) async => true);
      when(mockRemoteRepository.parseNovel(tParser, tUrl))
          .thenAnswer((_) async => Right(tNovel));
      when(mockLocalRepository.saveNovel(tNovel))
          .thenAnswer((_) async => Right(tNovelEntity));

      final result = await usecase.execute(tParser, tUrl);

      expect(result, Right(tNovelEntity));
      verify(mockLocalRepository.saveNovel(tNovel)).called(1);
    },
  );
}
