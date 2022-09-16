import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

final deleteNovelHistoryProvider = Provider<DeleteNovelHistory>(
  (ref) => DeleteNovelHistory(
    database: ref.watch(databaseProvider),
  ),
  name: "DeleteNovelHistoryProvider",
);

/// See [execute] for more information.
class DeleteNovelHistory {
  const DeleteNovelHistory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  /// Delete all history entries from specified novels of [novelIds]
  Future<void> execute(Iterable<int> novelIds) async {
    await _database.batch((batch) {
      for (final id in novelIds) {
        batch.deleteWhere<$ReadingHistoriesTable, ReadingHistory>(
          _database.readingHistories,
          (tbl) => tbl.novelId.equals(id),
        );
      }
    });
  }
}
