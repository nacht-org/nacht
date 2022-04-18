import 'package:chapturn/data/entities/reading_direction.dart';
import 'package:chapturn/data/entities/status.dart';
import 'package:chapturn/data/entities/work_type.dart';
import 'package:drift/drift.dart';

class Novels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get thumbnailUrl => text()();
  TextColumn get url => text()();
  IntColumn get statusId => integer().references(Statuses, #id)();
  TextColumn get lang => text().withLength(max: 8)();
  IntColumn get workTypeId => integer().references(WorkTypes, #id)();
  IntColumn get readingDirectionId =>
      integer().references(ReadingDirections, #id)();
}
