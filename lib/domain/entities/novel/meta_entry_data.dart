import 'dart:convert';

import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/data/data.dart';

part 'meta_entry_data.freezed.dart';

@freezed
class MetaEntryData with _$MetaEntryData {
  factory MetaEntryData({
    required int id,
    required String name,
    required String value,
    required sources.Namespace namespace,
    required Map<String, Object> others,
    required int novelId,
  }) = _MetaEntryData;

  factory MetaEntryData.fromModel(MetaEntry metaData) {
    return MetaEntryData(
      id: metaData.id,
      name: metaData.name,
      value: metaData.value,
      namespace: NamespaceSeed.intoNamespace(metaData.namespaceId),
      others: metaData.others == null
          ? {}
          : Map<String, Object>.from(json.decode(metaData.others!)),
      novelId: metaData.novelId,
    );
  }

  MetaEntryData._();
}
