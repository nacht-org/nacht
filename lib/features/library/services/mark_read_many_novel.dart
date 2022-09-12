import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/app_database.dart';

final markReadManyNovel = Provider<MarkReadManyNovel>(
  (ref) => MarkReadManyNovel(
    database: ref.watch(databaseProvider),
  ),
  name: 'MarkAsReadNovelsProvider',
);

/// Mark all chapters of the given novels as read at current time
/// The chapters already marked as read are left alone.
class MarkReadManyNovel {
  const MarkReadManyNovel({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> execute(Iterable<int> ids) async {
    final query = _database.update(_database.chapters)
      ..where((tbl) => tbl.readAt.isNull() & tbl.novelId.isIn(ids));

    await query.write(ChaptersCompanion(readAt: Value(DateTime.now())));
  }
}
