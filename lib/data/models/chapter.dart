import 'package:chapturn/data/models/volume.dart';
import 'package:drift/drift.dart';

class Chapters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get index => integer()();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  TextColumn get url => text()();
  DateTimeColumn get updated => dateTime().nullable()();
  IntColumn get volumeId => integer().references(Volumes, #id)();
}
