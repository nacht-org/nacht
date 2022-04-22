import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/data/mappers/status_mapper.dart';
import 'package:chapturn/data/models/status.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import 'mapper_helper.dart';

void main() {
  mapperGroup<NovelStatus, int>(
    name: 'NovelStatusMapper',
    mapper: NovelStatusToSeedMapper(),
    test: (mapper) {
      mapperTest(
        'NovelStatus.ongoing',
        'StatusSeed.ongoing',
        from: NovelStatus.ongoing,
        to: StatusSeed.ongoing,
        mapper: mapper,
      );

      mapperTest(
        'NovelStatus.hiatus',
        'StatusSeed.hiatus',
        from: NovelStatus.hiatus,
        to: StatusSeed.hiatus,
        mapper: mapper,
      );

      mapperTest(
        'NovelStatus.completed',
        'StatusSeed.completed',
        from: NovelStatus.completed,
        to: StatusSeed.completed,
        mapper: mapper,
      );

      mapperTest(
        'NovelStatus.unknown',
        'StatusSeed.unknown',
        from: NovelStatus.unknown,
        to: StatusSeed.unknown,
        mapper: mapper,
      );
    },
  );

  mapperGroup(
      name: 'SeedToNovelStatusMapper',
      mapper: SeedToNovelStatusMapper(),
      test: (mapper) {
        mapperTest(
          'StatusSeed.ongoing',
          'NovelStatus.ongoing',
          from: StatusSeed.ongoing,
          to: NovelStatus.ongoing,
          mapper: mapper,
        );

        mapperTest(
          'StatusSeed.hiatus',
          'NovelStatus.hiatus',
          from: StatusSeed.hiatus,
          to: NovelStatus.hiatus,
          mapper: mapper,
        );

        mapperTest(
          'StatusSeed.completed',
          'NovelStatus.completed',
          from: StatusSeed.completed,
          to: NovelStatus.completed,
          mapper: mapper,
        );

        mapperTest(
          'StatusSeed.unknown',
          'NovelStatus.unknown',
          from: StatusSeed.unknown,
          to: NovelStatus.unknown,
          mapper: mapper,
        );
      });
}
