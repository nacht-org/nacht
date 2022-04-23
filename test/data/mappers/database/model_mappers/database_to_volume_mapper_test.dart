import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/database_mappers/model_mappers/database_to_volume_mapper.dart';
import 'package:chapturn/domain/entities/novel/volume_entity.dart';

import '../../mapper_helper.dart';

void main() {
  mapperGroup<Volume, VolumeEntity>(
    name: 'DatabaseToVolumeMapper',
    mapper: DatabaseToVolumeMapper(),
    test: (mapper) {
      mapperTest(
        'db.Volume',
        'VolumEntity',
        from: Volume(
          id: 3,
          index: 3,
          name: 'Volume 3',
          novelId: 3,
        ),
        to: VolumeEntity(
          id: 3,
          index: 3,
          name: 'Volume 3',
          chapters: [],
          novelId: 3,
        ),
        mapper: mapper,
      );
    },
  );
}
