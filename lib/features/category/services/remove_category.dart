import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

final removeCategoryProvider = Provider<RemoveCategory>(
  (ref) => RemoveCategory(
    database: ref.watch(databaseProvider),
  ),
  name: "RemoveCategoryProvider",
);

class RemoveCategory {
  RemoveCategory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, void>> execute(Iterable<int> ids) async {
    await _database.batch((batch) {
      for (final id in ids) {
        batch.deleteWhere<NovelCategories, void>(
          _database.novelCategories,
          (tbl) => tbl.id.equals(id),
        );
      }
    });

    return const Right(null);
  }
}
