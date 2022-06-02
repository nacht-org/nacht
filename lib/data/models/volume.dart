import 'package:drift/drift.dart';
import 'package:nacht/data/data.dart';

class Volumes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get volumeIndex => integer()();
  TextColumn get name => text().withLength(max: 124)();
  IntColumn get novelId => integer().references(Novels, #id)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(novel_id, volume_index)',
      ];
}
