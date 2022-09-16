import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';

@DataClassName("ReadingHistory")
class ReadingHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get addedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get novelId => integer().references(Novels, #id)();
  IntColumn get chapterId => integer().references(Chapters, #id)();
}
