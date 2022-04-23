import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/domain/entities/novel/volume_entity.dart';
import 'package:chapturn/domain/mapper.dart';

class DatabaseToVolumeMapper implements Mapper<Volume, VolumeEntity> {
  @override
  VolumeEntity map(Volume input) {
    return VolumeEntity(
      id: input.id,
      index: input.index,
      name: input.name,
      chapters: [],
      novelId: input.novelId,
    );
  }
}
