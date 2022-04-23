import 'package:chapturn/domain/entities/novel_entity.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:chapturn/domain/usecases/parse_or_get_novel.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:chapturn/data/datasources/local/database.dart' as db;

import '../../helpers/test_helper.mocks.dart';
import 'parse_or_get_novel_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<Mapper<Novel, db.NovelsCompanion>>(
      as: #MockNovelCompanionFromNovelMapper)
])
void main() {
  late NovelRemoteRepository mockRemoteRepository;
  late NovelLocalRepository mockLocalRepository;
  late NetworkRepository mockNetworkRepository;
  late Mapper<Novel, db.NovelsCompanion> mockNovelCompanionMapper;
  late ParseOrGetNovel usecase;

  setUp(() {
    mockRemoteRepository = MockNovelRemoteRepository();
    mockLocalRepository = MockNovelLocalRepository();
    mockNetworkRepository = MockNetworkRepository();
    mockNovelCompanionMapper = MockNovelCompanionFromNovelMapper();
    usecase = ParseOrGetNovel(
      mockRemoteRepository,
      mockLocalRepository,
      mockNetworkRepository,
      mockNovelCompanionMapper,
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

  const tDbNovel = db.NovelsCompanion(
    title: Value('My novel story'),
    url: Value(tUrl),
    lang: Value('en'),
  );

  final tNovelEntity = NovelEntity(
    id: tId,
    title: 'My novel story',
    url: tUrl,
    author: 'My',
    description: [],
    thumbnailUrl: 'https://assets.website.com/novel/123/cover.jpg',
    status: NovelStatus.unknown,
    lang: 'en',
    volumes: [],
    metadata: [],
    workType: const OriginalWork(),
    readingDirection: ReadingDirection.ltr,
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
      when(mockNovelCompanionMapper.map(tNovel)).thenReturn(tDbNovel);
      when(mockLocalRepository.saveNovel(tDbNovel))
          .thenAnswer((_) async => const Right(tId));
      when(mockLocalRepository.getNovel(tId))
          .thenAnswer((_) async => Right(tNovelEntity));

      final result = await usecase.execute(tParser, tUrl);

      expect(result, Right(tNovelEntity));
      verify(mockLocalRepository.saveNovel(tDbNovel)).called(1);
    },
  );
}
