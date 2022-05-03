import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:chapturn/domain/usecases/novel/get_novel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/model_helper.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late NovelRepository mockNovelLocalRepository;
  late GetNovel usecase;

  setUp(() {
    mockNovelLocalRepository = MockNovelLocalRepository();
    usecase = GetNovel(
      novelRepository: mockNovelLocalRepository,
      assetRepository: MockAssetRepository(),
    );
  });

  final tNovel = helperNovelEntity;

  test('should get novel from local repository', () async {
    when(mockNovelLocalRepository.getNovel(tNovel.id))
        .thenAnswer((_) async => Right(tNovel));

    final result = await usecase.execute(tNovel.id);

    expect(result, Right(tNovel));
  });
}
