import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/data/mappers/work_type_mapper.dart';
import 'package:chapturn/data/models/work_type.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import 'mapper_helper.dart';

void main() {
  mapperGroup<WorkType, int>(
    name: 'WorkTypeMapper',
    mapper: WorkTypeMapper(),
    test: (mapper) {
      mapperTest(
        name: 'original',
        entity: const OriginalWork(),
        model: WorkTypeSeed.original,
        mapper: mapper,
      );
      mapperTest(
        name: 'translationMtl',
        entity: const TranslatedWork.mtl(),
        model: WorkTypeSeed.translationMtl,
        mapper: mapper,
      );
      mapperTest(
        name: 'translationHuman',
        entity: const TranslatedWork.human(),
        model: WorkTypeSeed.translationHuman,
        mapper: mapper,
      );
      mapperTest(
        name: 'translationUnknown',
        entity: const TranslatedWork.unknown(),
        model: WorkTypeSeed.translationUnknown,
        mapper: mapper,
      );
      mapperTest(
        name: 'unknown',
        entity: const UnknownWorkType(),
        model: WorkTypeSeed.unknown,
        mapper: mapper,
      );
    },
  );
}
