import 'package:chapturn/data/datasources/local/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'metadata_entity.freezed.dart';

@freezed
class MetaDataEntity with _$MetaDataEntity {
  factory MetaDataEntity({
    required int id,
    required String name,
    required String value,
    required Namespace namespace,
    required Map<String, Object> others,
  }) = _MetaDataEntity;
}
