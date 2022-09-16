import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

final deleteHistoryProvider = Provider<DeleteHistory>(
  (ref) => DeleteHistory(
    database: ref.watch(databaseProvider),
  ),
  name: "DeleteHistoryProvider",
);

/// See [execute] for more information
class DeleteHistory {
  const DeleteHistory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  /// Delete the specified history entries via [historyIds]
  Future<void> execute(Iterable<int> historyIds) async {
    await _database.batch((batch) {
      for (final id in historyIds) {
        batch.delete(
          _database.readingHistories,
          ReadingHistoriesCompanion(id: Value(id)),
        );
      }
    });
  }
}
