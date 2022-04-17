import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:modinate_core/modinate_core.dart';

extension Migrate on Migration {
  Future<void> apply(Database db) async {
    final data = await rootBundle.loadString(path, cache: false);
    await db.execute(data);
  }
}
