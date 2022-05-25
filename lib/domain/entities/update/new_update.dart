import 'package:nacht/data/data.dart';
import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_update.freezed.dart';

@freezed
class NewUpdate with _$NewUpdate {
  factory NewUpdate(int novel, int chapter) = _NewUpdate;

  UpdatesCompanion intoCompanion() {
    return UpdatesCompanion(
      chapterId: drift.Value(chapter),
      novelId: drift.Value(novel),
      updatedAt: drift.Value(DateTime.now()),
    );
  }

  NewUpdate._();
}
