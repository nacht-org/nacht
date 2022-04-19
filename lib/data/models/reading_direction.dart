import 'package:drift/drift.dart';

class ReadingDirections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 32)();
}

class ReadingDirectionSeed {
  static const int ltr = 1;
  static const int rtl = 2;
}
