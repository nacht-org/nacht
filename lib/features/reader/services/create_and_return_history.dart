import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/app_database.dart';

final createAndReturnHistoryProvider = Provider<CreateAndReturnHistory>(
  (ref) => CreateAndReturnHistory(
    database: ref.watch(databaseProvider),
  ),
  name: "CreateAndReturnHistoryProvider",
);

class CreateAndReturnHistory with LoggerMixin {
  const CreateAndReturnHistory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<ReadingHistory> execute(int chapterId) async {
    final now = DateTime.now();
    final model =
        await _database.into(_database.readingHistories).insertReturning(
              ReadingHistoriesCompanion.insert(
                  addedAt: now, updatedAt: now, chapterId: chapterId),
            );

    log.fine("Created new history session with id ${model.id}.");
    return model;
  }
}
