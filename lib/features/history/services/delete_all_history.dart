import 'package:nacht/database/database.dart';
import 'package:riverpod/riverpod.dart';

final deleteAllHistoryProvider = Provider<DeleteAllHistory>(
  (ref) => DeleteAllHistory(
    database: ref.watch(databaseProvider),
  ),
);

/// See [call] for more information
class DeleteAllHistory {
  const DeleteAllHistory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> call() async {
    await _database.delete(_database.readingHistories).go();
  }
}
