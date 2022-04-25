import 'package:chapturn_sources/chapturn_sources.dart';
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
    required int novelId,
  }) = _MetaDataEntity;
}
