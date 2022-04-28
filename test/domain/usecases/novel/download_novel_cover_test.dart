import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/failure.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/repositories/asset_repository.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:chapturn/domain/usecases/novel/download_novel_cover.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/model_helper.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late NovelLocalRepository mockLocalRepository;
  late NetworkRepository mockNetworkRepository;
  late AssetRepository mockAssetRepository;
  late DownloadNovelCover usecase;

  setUp(() {
    mockLocalRepository = MockNovelLocalRepository();
    mockNetworkRepository = MockNetworkRepository();
    mockAssetRepository = MockAssetRepository();
    usecase = DownloadNovelCover(
      localRepository: mockLocalRepository,
      networkRepository: mockNetworkRepository,
      assetRepository: mockAssetRepository,
    );
  });

  final tAssetEntity = AssetEntity(
    id: 2,
    path: 'path/to/image',
    mimetype: 'image/',
  );

  final tNovelWithoutCoverUrl = helperNovelEntity.copyWith(
    coverUrl: null,
  );

  final tNovelWithCover = helperNovelEntity.copyWith(
    cover: tAssetEntity,
  );

  final tNovel = helperNovelEntity;

  const tCompanion = AssetsCompanion();

  test('should throw cover not available if novel has no cover', () async {
    final result = await usecase.execute(tNovelWithoutCoverUrl);

    expect(result, const Left(CoverNotAvailable()));
  });

  test('should throw network not available when connection is unavailable',
      () async {
    when(mockNetworkRepository.isConnectionAvailable())
        .thenAnswer((_) async => false);

    final result = await usecase.execute(tNovel);

    expect(result, const Left(NetworkNotAvailable()));
  });

  test('should return saved asset entity from asset repository', () async {
    when(mockNetworkRepository.isConnectionAvailable())
        .thenAnswer((_) async => true);
    when(mockAssetRepository.downloadAsset(tNovel.coverUrl!))
        .thenAnswer((_) async => const Right(tCompanion));
    when(mockAssetRepository.addAsset(tCompanion))
        .thenAnswer((_) async => Right(tAssetEntity));

    final result = await usecase.execute(tNovel);

    expect(result, Right(tAssetEntity));
  });

  test('should delete existing novel cover', () async {
    when(mockNetworkRepository.isConnectionAvailable())
        .thenAnswer((_) async => true);
    when(mockAssetRepository.downloadAsset(tNovel.coverUrl!))
        .thenAnswer((_) async => const Right(tCompanion));
    when(mockAssetRepository.deleteAsset(tNovelWithCover.cover!))
        .thenAnswer((_) async => const Right(null));
    when(mockAssetRepository.addAsset(tCompanion))
        .thenAnswer((_) async => Right(tAssetEntity));

    final result = await usecase.execute(tNovelWithCover);

    expect(result, Right(tAssetEntity));
    verify(mockAssetRepository.deleteAsset(tNovelWithCover.cover!)).called(1);
  });
}
