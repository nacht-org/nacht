import 'dart:convert';

import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:drift/drift.dart';

class SourceToMetaDataCompanionMapper
    implements Mapper<sources.MetaData, MetaDatasCompanion> {
  const SourceToMetaDataCompanionMapper(this.namespaceMapper);

  final Mapper<sources.Namespace, int> namespaceMapper;

  @override
  MetaDatasCompanion map(sources.MetaData input) {
    return MetaDatasCompanion(
      name: Value(input.name),
      value: Value(input.value),
      namespaceId: Value(namespaceMapper.map(input.namespace)),
      others: Value(input.others.isEmpty ? null : json.encode(input.others)),
    );
  }
}
