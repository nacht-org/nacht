import 'package:chapturn/domain/entities/category/category_entity.dart';
import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:chapturn/domain/usecases/category/change_novel_categories.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late NovelLocalRepository mockLocalRepository;
  late CategoryRepository mockCategoryRepository;
  late ChangeNovelCategories usecase;

  setUp(() {
    mockLocalRepository = MockNovelLocalRepository();
    mockCategoryRepository = MockCategoryRepository();
    usecase = ChangeNovelCategories(
      categoryRepository: mockCategoryRepository,
      novelLocalRepository: mockLocalRepository,
    );
  });

  final tNovelEntity = NovelEntity(
    id: 1,
    title: 'My novel story',
    url: 'https://website.com/novel/123',
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

  final tCategories = [
    CategoryEntity(id: 1, name: '_default', isDefault: true),
  ];

  test('should update categories with category repository', () async {
    final result = await usecase.execute(tNovelEntity, tCategories);

    verify(mockCategoryRepository.changeNovelCategories(
            tNovelEntity, tCategories))
        .called(1);
  });

  test('should set favourite to false when catergories is empty', () async {
    final result = await usecase.execute(tNovelEntity, []);
    verify(mockLocalRepository.setFavourite(tNovelEntity.id, false)).called(1);
  });

  test('should set favourite to true when catergories is not empty', () async {
    final result = await usecase.execute(tNovelEntity, tCategories);
    verify(mockLocalRepository.setFavourite(tNovelEntity.id, true)).called(1);
  });
}
