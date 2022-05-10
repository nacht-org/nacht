import 'package:chapturn/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/model_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late CategoryRepository mockCategoryRepository;
  late NovelRepository mockNovelRepository;
  late LibraryService service;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    mockNovelRepository = MockNovelRepository();
    service = LibraryService(
      categoryRepository: mockCategoryRepository,
      novelRepository: mockNovelRepository,
    );
  });

  final tNovelEntity = helperNovelEntity;

  final tCategories = {
    CategoryData(
        id: 1, index: 1, name: '_default', isDefault: true, novels: []): true,
  };

  final tUnselectedCategories = {
    CategoryData(
        id: 1, index: 1, name: '_default', isDefault: true, novels: []): false,
  };

  group('changeCategory', () {
    test('should update categories with category repository', () async {
      await service.changeCategory(tNovelEntity, tCategories);

      verify(mockCategoryRepository.changeNovelCategories(
              tNovelEntity, tCategories))
          .called(1);
    });

    test('should set favourite to false when selected catergories is empty',
        () async {
      await service.changeCategory(tNovelEntity, tUnselectedCategories);
      verify(mockNovelRepository.setFavourite(tNovelEntity.id, false))
          .called(1);
    });

    test('should set favourite to true when selected catergories is not empty',
        () async {
      await service.changeCategory(tNovelEntity, tCategories);
      verify(mockNovelRepository.setFavourite(tNovelEntity.id, true)).called(1);
    });
  });

  group('categories', () {
    final tCategory = CategoryData(
        id: 1, index: 1, name: '_default', isDefault: true, novels: []);

    final tCategories = [
      tCategory,
    ];

    final tNovelEntity = helperNovelEntity;

    test('should get categories from categories repository', () async {
      when(mockCategoryRepository.getAllCategories())
          .thenAnswer((_) async => tCategories);

      final result = await service.categories();

      expect(result, tCategories);
    });

    test(
      'should return categories with novels from category repository',
      () async {
        when(mockCategoryRepository.getAllCategories())
            .thenAnswer((_) async => tCategories);
        when(mockCategoryRepository.getNovelsOfCategory(tCategory))
            .thenAnswer((_) async => [tNovelEntity]);

        final result = await service.categories(fetchNovels: true);

        expect(result, [
          tCategory.copyWith(novels: [tNovelEntity]),
        ]);
      },
    );
  });
}
