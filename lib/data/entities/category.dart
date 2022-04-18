import 'package:chapturn/data/entities/novel.dart';
import 'package:drift/drift.dart';

@DataClassName('NovelCategory')
class NovelCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text()();

  static const int defaultCategory = 1;
}

class NovelCategoriesJunction extends Table {
  IntColumn get categoryId => integer().references(NovelCategories, #id)();
  IntColumn get novelId => integer().references(Novels, #id)();
}
