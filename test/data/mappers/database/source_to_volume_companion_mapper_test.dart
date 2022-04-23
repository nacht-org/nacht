import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/mappers.dart';
import 'package:drift/drift.dart';

import '../mapper_helper.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

void main() {
  mapperGroup(
    name: 'SourceToVolumeCompanionMapper',
    mapper: SourceToVolumeCompanionMapper(),
    test: (mapper) {
      mapperTest(
        'sources.Volume',
        'VolumesCompanion',
        from: sources.Volume(
          index: 1,
          name: 'volume 1',
        ),
        to: const VolumesCompanion(
          index: Value(1),
          name: Value('volume 1'),
        ),
        mapper: mapper,
      );
    },
  );
}
