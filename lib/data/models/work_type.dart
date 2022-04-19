import 'package:drift/drift.dart';

class WorkTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 32)();
}

class WorkTypeSeed {
  static const int original = 1;
  static const int translationMtl = 2;
  static const int translationHuman = 3;
  static const int translationUnknown = 4;
  static const int unknown = 5;
}
