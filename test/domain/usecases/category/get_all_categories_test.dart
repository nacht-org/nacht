import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';
import 'package:chapturn/domain/usecases/category/get_all_categories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late CategoryRepository mockCategoryRepository;
  late GetAllCategories usecase;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    usecase = GetAllCategories(mockCategoryRepository);
  });

  final tCategories = [
    CategoryEntity(id: 1, name: '_default', isDefault: true),
  ];

  test('should get categories from categories repository', () async {
    when(mockCategoryRepository.getAllCategories())
        .thenAnswer((_) async => tCategories);

    final result = await usecase.execute();

    expect(result, tCategories);
  });
}
