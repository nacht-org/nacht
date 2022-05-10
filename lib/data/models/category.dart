import 'package:chapturn/data/models/novel.dart';
import 'package:drift/drift.dart';

@DataClassName('NovelCategory')
class NovelCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryIndex =>
      integer().customConstraint('NOT NULL UNIQUE')();
  TextColumn get name => text()();
}

class NovelCategorySeed {
  static const int defaultCategory = 1;
}

class NovelCategoriesJunction extends Table {
  IntColumn get categoryId => integer().references(NovelCategories, #id)();
  IntColumn get novelId => integer().references(Novels, #id)();

  @override
  List<String> get customConstraints => [
        'PRIMARY KEY(category_id, novel_id)',
      ];
}
