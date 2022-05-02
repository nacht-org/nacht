import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/data/mapper/mapper.dart';
import 'package:chapturn/data/models/reading_direction.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../../mapper_helper.dart';

void main() {
  mapperGroup<ReadingDirection, int>(
    name: 'ReadingDirectionToSeedMapper',
    mapper: ReadingDirectionToSeedMapper(),
    test: (mapper) {
      mapperTest(
        'ReadingDirection.ltr',
        'ReadingDirectionSeed.ltr',
        from: ReadingDirection.ltr,
        to: ReadingDirectionSeed.ltr,
        mapper: mapper,
      );

      mapperTest(
        'ReadingDirection.rtl',
        'ReadingDirectionSeed.rtl',
        from: ReadingDirection.rtl,
        to: ReadingDirectionSeed.rtl,
        mapper: mapper,
      );
    },
  );

  mapperGroup(
    name: 'SeedToReadingDirectionMapper',
    mapper: SeedToReadingDirectionMapper(),
    test: (mapper) {
      mapperTest(
        'ReadingDirectionSeed.ltr',
        'ReadingDirection.ltr',
        from: ReadingDirectionSeed.ltr,
        to: ReadingDirection.ltr,
        mapper: mapper,
      );

      mapperTest(
        'ReadingDirectionSeed.rtl',
        'ReadingDirection.rtl',
        from: ReadingDirectionSeed.rtl,
        to: ReadingDirection.rtl,
        mapper: mapper,
      );
    },
  );
}
