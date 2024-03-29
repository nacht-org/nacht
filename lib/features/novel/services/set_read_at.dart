import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

final setReadAtProvider = Provider<SetReadAt>(
  (ref) => SetReadAt(
    database: ref.watch(databaseProvider),
  ),
  name: "SetReadAtProvider",
);

class SetReadAt {
  SetReadAt({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Failure?> execute(Iterable<int> chapterIds, bool isRead) async {
    final readAt = isRead ? DateTime.now() : null;
    await _database.batch((batch) {
      for (final id in chapterIds) {
        final companion = ChaptersCompanion(
          readAt: Value(readAt),
        );

        batch.update<Chapters, Chapter>(
          _database.chapters,
          companion,
          where: (tbl) => tbl.id.equals(id),
        );
      }
    });

    return null;
  }
}
