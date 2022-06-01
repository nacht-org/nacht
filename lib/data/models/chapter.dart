import 'package:drift/drift.dart';

import 'assets.dart';
import 'novel.dart';
import 'volume.dart';

class Chapters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterIndex => integer()();
  TextColumn get title => text()();
  IntColumn get content => integer().nullable().references(Assets, #id)();
  TextColumn get url => text()();
  DateTimeColumn get updated => dateTime().nullable()();
  DateTimeColumn get readAt => dateTime().nullable()();

  IntColumn get novelId => integer().references(Novels, #id)();
  IntColumn get volumeId => integer().references(Volumes, #id)();

  @override
  List<String> get customConstraints => [
        'UNIQUE(volume_id, url)',
      ];
}
