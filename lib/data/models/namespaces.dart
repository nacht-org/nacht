import 'package:drift/drift.dart';

class Namespaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 8)();
}

class NamespaceSeed {
  static const int dc = 1;
  static const int opf = 2;
}
