import 'package:drift/drift.dart';

import 'namespaces.dart';
import 'novel.dart';

@DataClassName('MetaEntry')
class MetaEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get value => text()();
  IntColumn get namespaceId => integer().references(Namespaces, #id)();
  TextColumn get others => text().nullable()();
  IntColumn get novelId => integer().references(Novels, #id)();
}
