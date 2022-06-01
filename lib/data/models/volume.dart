import 'package:drift/drift.dart';

class Volumes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get volumeIndex => integer()();
  TextColumn get name => text().withLength(max: 124)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(novel_id, volume_index)',
      ];
}
