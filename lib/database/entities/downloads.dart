import 'package:drift/drift.dart';

import 'chapter.dart';

class Downloads extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderIndex => integer()();
  IntColumn get chapterId => integer().references(Chapters, #id)();
  DateTimeColumn get createdAt => dateTime()();
}
