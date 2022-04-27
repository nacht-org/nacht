import 'package:chapturn/domain/entities/category/novel_category_entity.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';

class GetAllCategoriesWithNovels {
  GetAllCategoriesWithNovels({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  Future<List<NovelCategoryEntity>> execute() async {
    final categories = await categoryRepository.getAllCategories();

    final entities = <NovelCategoryEntity>[];
    for (final category in categories) {
      final novels = await categoryRepository.getNovelsOfCategory(category);
      entities.add(NovelCategoryEntity(category, novels));
    }

    return entities;
  }
}
