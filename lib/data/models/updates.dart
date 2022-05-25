import 'package:nacht/data/models/chapter.dart';
import 'package:nacht/data/models/novel.dart';
import 'package:drift/drift.dart';

class Updates extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterId => integer().references(Chapters, #id)();
  IntColumn get novelId => integer().references(Novels, #id)();
  DateTimeColumn get updatedAt => dateTime()();
}
