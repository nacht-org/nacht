import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

import '../models/models.dart';
import 'services.dart';

final getNovelByIdProvider = Provider<GetNovelById>(
  (ref) => GetNovelById(
    database: ref.watch(databaseProvider),
    parseNovelQuery: ref.watch(parseNovelQueryProvider),
  ),
  name: 'GetNovelByIdProvider',
);

/// Retrieve novel from database by its id
class GetNovelById {
  GetNovelById({
    required AppDatabase database,
    required ParseNovelQuery parseNovelQuery,
  })  : _database = database,
        _parseNovelQuery = parseNovelQuery;

  final AppDatabase _database;
  final ParseNovelQuery _parseNovelQuery;

  Future<Either<Failure, NovelData>> execute(int id) {
    final query = _database.select(_database.novels).join([
      leftOuterJoin(
        _database.assets,
        _database.assets.id.equalsExp(_database.novels.coverId),
      ),
    ])
      ..where(_database.novels.id.equals(id));

    return _parseNovelQuery.execute(query);
  }
}
