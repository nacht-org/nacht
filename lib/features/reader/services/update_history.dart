import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

final updateHistoryProvider = Provider<UpdateHistory>(
  (ref) => UpdateHistory(
    database: ref.watch(databaseProvider),
  ),
  name: "UpdateHistoryProvider",
);

class UpdateHistory with LoggerMixin {
  const UpdateHistory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> execute(int historyId, int chapterId) async {
    final query = _database.update(_database.readingHistories)
      ..where((tbl) => tbl.id.equals(historyId));

    await query.write(ReadingHistoriesCompanion(
      updatedAt: Value(DateTime.now()),
      chapterId: Value(chapterId),
    ));

    log.fine("Updated reading history with id $historyId.");
  }
}
