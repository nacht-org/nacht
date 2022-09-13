import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

final markUnreadManyNovel = Provider<MarkUnreadManyNovel>(
  (ref) => MarkUnreadManyNovel(
    database: ref.watch(databaseProvider),
  ),
  name: "MarkUnreadManyNovel",
);

/// Mark all chapters of given novel as unread
class MarkUnreadManyNovel {
  const MarkUnreadManyNovel({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> execute(Iterable<int> ids) async {
    final query = _database.update(_database.chapters)
      ..where((tbl) => tbl.novelId.isIn(ids));

    await query.write(const ChaptersCompanion(readAt: Value(null)));
  }
}
