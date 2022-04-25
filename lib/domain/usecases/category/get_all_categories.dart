import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';

class GetAllCategories {
  GetAllCategories(this.categoryRepository);

  final CategoryRepository categoryRepository;

  Future<List<CategoryEntity>> execute() async {
    return await categoryRepository.getAllCategories();
  }
}
