import 'dart:io';

import 'package:nacht/data/failure.dart';
import 'package:nacht/domain/domain.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/model_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NovelRepository mockNovelRepository;
  late AssetRepository mockAssetRepository;
  late NetworkRepository mockNetworkRepository;
  late GatewayRepository mockGatewayRepository;
  late UpdatesRepository mockUpdatesRepository;
  late NovelService service;

  setUp(() {
    mockNovelRepository = MockNovelRepository();
    mockAssetRepository = MockAssetRepository();
    mockNetworkRepository = MockNetworkRepository();
    mockGatewayRepository = MockGatewayRepository();
    mockUpdatesRepository = MockUpdatesRepository();
    service = NovelService(
      novelRepository: mockNovelRepository,
      assetRepository: mockAssetRepository,
      networkRepository: mockNetworkRepository,
      gatewayRepository: mockGatewayRepository,
      updatesRepository: mockUpdatesRepository,
    );
  });

  group('getById', () {
    final tNovel = helperNovelEntity;

    test('should get novel from local repository', () async {
      when(mockNovelRepository.getNovel(tNovel.id))
          .thenAnswer((_) async => Right(tNovel));

      final result = await service.getById(tNovel.id);

      expect(result, Right(tNovel));
    });
  });

  group('parseOrGet', () {
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
      chapters: [],
      metadata: [],
      workType: const OriginalWork(),
      readingDirection: ReadingDirection.ltr,
      favourite: false,
    );

    final tUpdateResult = UpdateResult(
      initial: false,
      novel: 1,
      inserted: [],
    );

    test(
      'should return from local repository when connection is unavailable',
      () async {
        when(mockNetworkRepository.isConnectionAvailable())
            .thenAnswer((_) async => false);
        when(mockNovelRepository.getNovelByUrl(tUrl))
            .thenAnswer((_) async => Right(tNovelEntity));

        final result = await service.parseOrGet(tParser, tUrl);

        expect(result, Right(tNovelEntity));
      },
    );

    test(
      'should update local novel entry when connection is available',
      () async {
        when(mockNetworkRepository.isConnectionAvailable())
            .thenAnswer((_) async => true);
        when(mockGatewayRepository.parseNovel(tParser, tUrl))
            .thenAnswer((_) async => Right(tNovel));
        when(mockNovelRepository.updateNovel(tNovel))
            .thenAnswer((_) async => Right(tUpdateResult));
        when(mockUpdatesRepository.addAll(tUpdateResult.intoNewUpdates()))
            .thenAnswer((_) async => const Right(null));
        when(mockNovelRepository.getNovelByUrl(tUrl))
            .thenAnswer((_) async => Right(tNovelEntity));

        final result = await service.parseOrGet(tParser, tUrl);

        expect(result, Right(tNovelEntity));
        verify(mockNovelRepository.updateNovel(tNovel)).called(1);
      },
    );
  });

  group('downloadCover', () {
    final tAssetEntity = AssetData(
      id: 2,
      file: File('path/to/image'),
      mimetype: 'image/',
      hash: 'hash',
      url: null,
    );

    final tNovelWithoutCoverUrl = helperNovelEntity.copyWith(
      coverUrl: null,
    );

    final tNovelWithCover = helperNovelEntity.copyWith(
      cover: tAssetEntity,
    );

    final tNovel = helperNovelEntity;

    final tAssetData = AssetInfo([], 'image/png', 'hash');

    test('should throw cover not available if novel has no cover', () async {
      final result = await service.downloadCover(tNovelWithoutCoverUrl);

      expect(result, const Left(CoverNotAvailable()));
    });

    test('should throw network not available when connection is unavailable',
        () async {
      when(mockNetworkRepository.isConnectionAvailable())
          .thenAnswer((_) async => false);

      final result = await service.downloadCover(tNovel);

      expect(result, const Left(NetworkNotAvailable()));
    });

    test('should return saved asset entity from asset repository', () async {
      when(mockNetworkRepository.isConnectionAvailable())
          .thenAnswer((_) async => true);
      when(mockAssetRepository.downloadAsset(tNovel.coverUrl!))
          .thenAnswer((_) async => Right(tAssetData));
      when(mockAssetRepository.addAsset(
              tNovel.id.toString(), tAssetData, tNovel.coverUrl))
          .thenAnswer((_) async => Right(tAssetEntity));

      final result = await service.downloadCover(tNovel);

      expect(result, Right(tAssetEntity));
    });

    test('should abort when downloaded data has the same hash value', () async {
      when(mockNetworkRepository.isConnectionAvailable())
          .thenAnswer((_) async => true);
      when(mockAssetRepository.downloadAsset(tNovel.coverUrl!))
          .thenAnswer((_) async => Right(tAssetData));

      final result = await service.downloadCover(tNovelWithCover);

      expect(result, const Left(SameAssetError()));
      verifyNever(mockAssetRepository.deleteAsset(tNovelWithCover.cover!));
    });

    test('should delete existing novel cover if hash is different', () async {
      final tLocalAssetData = tAssetData.copyWith(hash: 'different');

      when(mockNetworkRepository.isConnectionAvailable())
          .thenAnswer((_) async => true);
      when(mockAssetRepository.downloadAsset(tNovel.coverUrl!))
          .thenAnswer((_) async => Right(tLocalAssetData));
      when(mockAssetRepository.deleteAsset(tNovelWithCover.cover!))
          .thenAnswer((_) async => const Right(null));
      when(mockAssetRepository.addAsset(
              tNovel.id.toString(), tLocalAssetData, tNovelWithCover.coverUrl))
          .thenAnswer((_) async => Right(tAssetEntity));

      final result = await service.downloadCover(tNovelWithCover);

      expect(result, Right(tAssetEntity));
      verify(mockAssetRepository.deleteAsset(tNovelWithCover.cover!)).called(1);
    });
  });
}
