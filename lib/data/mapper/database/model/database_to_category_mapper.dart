import 'package:chapturn/data/models/category.dart';
import 'package:chapturn/domain/entities/entities.dart';

import '../../../../domain/mapper.dart';
import '../../../datasources/local/database.dart';

class DatabaseToCategoryMapper
    implements Mapper<NovelCategory, CategoryEntity> {
  @override
  CategoryEntity from(NovelCategory input) {
    return CategoryEntity(
      id: input.id,
      name: input.name,
      isDefault: input.id == NovelCategorySeed.defaultCategory,
    );
  }
}
