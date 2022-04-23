import 'package:chapturn/data/datasources/local/database.dart' as db;
import 'package:chapturn/data/mappers/database/work_type_mapper.dart';
import 'package:chapturn/data/models/work_type.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../mapper_helper.dart';

void main() {
  mapperGroup<WorkType, int>(
    name: 'WorkTypeToSeedMapper',
    mapper: WorkTypeToSeedMapper(),
    test: (mapper) {
      mapperTest(
        'OriginalWork',
        'original',
        from: const OriginalWork(),
        to: WorkTypeSeed.original,
        mapper: mapper,
      );
      mapperTest(
        'TranslatedWork.mtl',
        'translationMtl',
        from: const TranslatedWork.mtl(),
        to: WorkTypeSeed.translationMtl,
        mapper: mapper,
      );
      mapperTest(
        'TranslatedWork.human',
        'translationHuman',
        from: const TranslatedWork.human(),
        to: WorkTypeSeed.translationHuman,
        mapper: mapper,
      );
      mapperTest(
        'TranslatedWork.unknown',
        'translationUnknown',
        from: const TranslatedWork.unknown(),
        to: WorkTypeSeed.translationUnknown,
        mapper: mapper,
      );
      mapperTest(
        'UnknownWorkType',
        'unknown',
        from: const UnknownWorkType(),
        to: WorkTypeSeed.unknown,
        mapper: mapper,
      );
    },
  );

  mapperGroup(
      name: 'SeedToWorkTypeMapper',
      mapper: SeedToWorkTypeMapper(),
      test: (mapper) {
        mapperTest(
          'original',
          'OriginalWork',
          from: WorkTypeSeed.original,
          to: const OriginalWork(),
          mapper: mapper,
        );
        mapperTest(
          'translationMtl',
          from: WorkTypeSeed.translationMtl,
          'TranslatedWork.mtl',
          to: const TranslatedWork.mtl(),
          mapper: mapper,
        );
        mapperTest(
          'translationHuman',
          'TranslatedWork.human',
          from: WorkTypeSeed.translationHuman,
          to: const TranslatedWork.human(),
          mapper: mapper,
        );
        mapperTest(
          'translationUnknown',
          'TranslatedWork.unknown',
          from: WorkTypeSeed.translationUnknown,
          to: const TranslatedWork.unknown(),
          mapper: mapper,
        );
        mapperTest(
          'unknown',
          'UnknownWorkType',
          from: WorkTypeSeed.unknown,
          to: const UnknownWorkType(),
          mapper: mapper,
        );
      });
}
