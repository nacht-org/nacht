import 'package:drift/drift.dart';

@DataClassName('Status')
class Statuses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 32)();

  static const int ongoing = 1;
  static const int hiatus = 2;
  static const int completed = 3;
  static const int unknown = 4;
}
