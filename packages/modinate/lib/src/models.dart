import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class Migration {
  const Migration({
    required this.number,
    required this.name,
    required this.path,
  });

  final String name;
  final int number;
  final String path;

  Future<void> apply(Database db) async {
    final data = await rootBundle.loadString(path, cache: false);
    await db.execute(data);
  }
}
