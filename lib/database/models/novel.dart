import 'package:drift/drift.dart';

import 'assets.dart';
import 'reading_direction.dart';
import 'status.dart';
import 'work_type.dart';

class Novels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get author => text().nullable()();
  TextColumn get coverUrl => text().nullable()();
  IntColumn get coverId => integer().nullable().references(Assets, #id)();
  TextColumn get url => text().customConstraint('NOT NULL UNIQUE')();
  IntColumn get statusId => integer().references(Statuses, #id)();
  TextColumn get lang => text().withLength(max: 8)();
  IntColumn get workTypeId => integer().references(WorkTypes, #id)();
  IntColumn get readingDirectionId =>
      integer().references(ReadingDirections, #id)();
  BoolColumn get favourite => boolean().withDefault(const Constant(false))();
}
