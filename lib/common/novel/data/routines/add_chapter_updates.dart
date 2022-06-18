import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

final addChapterUpdatesProvider = Provider<AddChapterUpdates>(
  (ref) => AddChapterUpdates(
    database: ref.watch(databaseProvider),
  ),
  name: 'AddChapterUpdatesProvider',
);

/// Mark the chapters as updated at the given time.
class AddChapterUpdates {
  AddChapterUpdates({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Option<Failure>> execute(int novelId, Iterable<int> chapterIds) async {
    await _database.batch((batch) {
      for (final chapterId in chapterIds) {
        final companion = UpdatesCompanion.insert(
          chapterId: chapterId,
          novelId: novelId,
          updatedAt: DateTime.now(),
        );

        batch.insert(_database.updates, companion);
      }
    });

    return const None();
  }
}
