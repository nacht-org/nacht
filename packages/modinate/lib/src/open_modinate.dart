import 'package:modinate_core/modinate_core.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

Future<Database> openModinate({
  required String path,
  required List<Migration> migrations,
  bool singleInstance = true,
}) {
  return openDatabase(
    path,
    version: migrations.length + 1,
    onCreate: (db, version) async {
      for (final migration in migrations) {
        migration.apply(db);
      }
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      final migrationToApply = migrations.sublist(oldVersion, newVersion);
      for (final migration in migrationToApply) {
        migration.apply(db);
      }
    },
    singleInstance: singleInstance,
  );
}
