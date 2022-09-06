import 'package:drift/drift.dart';

import 'novel.dart';

@DataClassName('NovelCategory')
class NovelCategories extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// This value should be kept programmatically unique as its used to
  /// represent the order of categories shown in app.
  ///
  /// The [UNIQUE] constant is not added since it restricts changing the value.
  IntColumn get categoryIndex => integer()();
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
