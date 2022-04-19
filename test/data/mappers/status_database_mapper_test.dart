import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/data/mappers/status_mapper.dart';
import 'package:chapturn/data/models/status.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import 'mapper_helper.dart';

void main() {
  mapperGroup<NovelStatus, int>(
    name: 'NovelStatusMapper',
    mapper: NovelStatusMapper(),
    test: (mapper) {
      mapperTest(
        name: 'ongoing',
        entity: NovelStatus.ongoing,
        model: StatusSeed.ongoing,
        mapper: mapper,
      );

      mapperTest(
        name: 'hiatus',
        entity: NovelStatus.hiatus,
        model: StatusSeed.hiatus,
        mapper: mapper,
      );

      mapperTest(
        name: 'completed',
        entity: NovelStatus.completed,
        model: StatusSeed.completed,
        mapper: mapper,
      );

      mapperTest(
        name: 'unknown',
        entity: NovelStatus.unknown,
        model: StatusSeed.unknown,
        mapper: mapper,
      );
    },
  );
}
