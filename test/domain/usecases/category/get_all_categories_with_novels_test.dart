import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';
import 'package:chapturn/domain/usecases/category/get_all_categories_with_novels.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/model_helper.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late CategoryRepository mockCategoryRepository;
  late GetAllCategoriesWithNovels usecase;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    usecase = GetAllCategoriesWithNovels(
      categoryRepository: mockCategoryRepository,
    );
  });

  final tCategory = CategoryEntity(id: 1, name: '_default', isDefault: true);

  final tCategories = [
    tCategory,
  ];

  final tNovelEntity = helperNovelEntity;

  test(
    'should return categories with novels from category repository',
    () async {
      when(mockCategoryRepository.getAllCategories())
          .thenAnswer((_) async => tCategories);
      when(mockCategoryRepository.getNovelsOfCategory(tCategory))
          .thenAnswer((_) async => [tNovelEntity]);

      final result = await usecase.execute();

      expect(result, [
        NovelCategoryEntity(tCategory, [tNovelEntity]),
      ]);
    },
  );
}
