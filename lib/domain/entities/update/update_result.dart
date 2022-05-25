import 'package:nacht/domain/entities/update/new_update.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_result.freezed.dart';

@freezed
class UpdateResult with _$UpdateResult {
  factory UpdateResult({
    required bool initial,
    required int novel,
    required List<int> inserted,
  }) = _UpdateResult;

  UpdateResult._();

  List<NewUpdate> intoNewUpdates() {
    return inserted.map((id) => NewUpdate(novel, id)).toList();
  }
}
