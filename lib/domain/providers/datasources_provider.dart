import 'package:chapturn/data/datasources/local/database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final databaseProvider = Provider<AppDatabase>(
  (ref) => AppDatabase.connect(),
);
