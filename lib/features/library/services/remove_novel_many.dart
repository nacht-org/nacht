import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

final removeNovelManyProvider = Provider<RemoveNovelMany>(
  (ref) {
    return RemoveNovelMany(
      database: ref.watch(databaseProvider),
    );
  },
  name: 'RemoveNovelManyProvider',
);

/// Remove provided novels from library and unfavourite.
class RemoveNovelMany {
  const RemoveNovelMany({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> execute(Iterable<int> ids) async {
    // Remove from categories.
    await (_database.delete(_database.novelCategoriesJunction)
          ..where((tbl) => tbl.novelId.isIn(ids)))
        .go();

    // Unfavourite novels
    final query = _database.update(_database.novels)
      ..where((tbl) => tbl.id.isIn(ids));

    await query.write(const NovelsCompanion(favourite: Value(false)));
  }
}
