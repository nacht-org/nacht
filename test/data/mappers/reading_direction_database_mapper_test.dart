import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/data/mappers/reading_database_mapper.dart';
import 'package:chapturn/data/models/reading_direction.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import 'mapper_helper.dart';

void main() {
  mapperGroup<ReadingDirection, int>(
    name: 'ReadingDirectionMapper',
    mapper: ReadingDirectionMapper(),
    test: (mapper) {
      mapperTest(
        name: 'ltr',
        entity: ReadingDirection.ltr,
        model: ReadingDirectionSeed.ltr,
        mapper: mapper,
      );

      mapperTest(
        name: 'rtl',
        entity: ReadingDirection.rtl,
        model: ReadingDirectionSeed.rtl,
        mapper: mapper,
      );
    },
  );
}
