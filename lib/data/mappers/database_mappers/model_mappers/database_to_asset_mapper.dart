import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/database_mappers/seed_mappers/asset_type_mapper.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/mapper.dart';

class DatabaseToAssetMapper implements Mapper<Asset, AssetEntity> {
  DatabaseToAssetMapper({required this.seedToMimeTypeMapper});

  final Mapper<int, String> seedToMimeTypeMapper;

  @override
  AssetEntity map(Asset input) {
    return AssetEntity(
      id: input.id,
      url: input.url,
      path: input.path!,
      hash: input.hash,
      mimetype: seedToMimeTypeMapper.map(input.typeId),
    );
  }
}
