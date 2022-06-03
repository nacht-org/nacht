import 'package:drift/drift.dart';

import 'chapter.dart';
import 'novel.dart';

class Updates extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterId => integer().references(Chapters, #id)();
  IntColumn get novelId => integer().references(Novels, #id)();
  DateTimeColumn get updatedAt => dateTime()();
}
