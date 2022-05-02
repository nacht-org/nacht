import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mapper/mapper.dart';
import 'package:chapturn/domain/entities/entities.dart';

import '../../mapper_helper.dart';

void main() {
  mapperGroup(
    name: 'DatabaseToCategoryMapper',
    mapper: DatabaseToCategoryMapper(),
    test: (mapper) {
      mapperTest(
        'default db.NovelCategory',
        'CategoryEntity',
        from: NovelCategory(
          id: 1,
          name: '_default',
        ),
        to: CategoryEntity(
          id: 1,
          name: '_default',
          isDefault: true,
        ),
        mapper: mapper,
      );

      mapperTest(
        'non-default db.NovelCategory',
        'CategoryEntity',
        from: NovelCategory(
          id: 2,
          name: 'Reading',
        ),
        to: CategoryEntity(
          id: 2,
          name: 'Reading',
          isDefault: false,
        ),
        mapper: mapper,
      );
    },
  );
}
