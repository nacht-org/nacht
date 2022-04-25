import 'dart:convert';

import 'package:chapturn_sources/chapturn_sources.dart' as sources;

import '../../../../domain/entities/novel/metadata_entity.dart';
import '../../../../domain/mapper.dart';
import '../../../datasources/local/database.dart';

class DatabaseToMetaDataMapper implements Mapper<MetaData, MetaDataEntity> {
  DatabaseToMetaDataMapper(this.namespaceMapper);

  final Mapper<int, sources.Namespace> namespaceMapper;

  @override
  MetaDataEntity map(MetaData input) {
    return MetaDataEntity(
      id: input.id,
      name: input.name,
      value: input.value,
      namespace: namespaceMapper.map(input.namespaceId),
      others: input.others == null ? {} : json.decode(input.others!),
      novelId: input.novelId,
    );
  }
}
