import 'package:chapturn/data/entities/novel.dart';
import 'package:drift/drift.dart';

class Volumes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get index => integer()();
  TextColumn get name => text().withLength(max: 124)();
  IntColumn get novelId => integer().references(Novels, #id)();
}
