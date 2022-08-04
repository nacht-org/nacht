import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

import '../entities/novel_data.dart';
import '../routines/parse_novel_query.dart';

final getNovelByUrlProvider = Provider<GetNovelByUrl>(
  (ref) => GetNovelByUrl(
    database: ref.watch(databaseProvider),
    parseNovelQuery: ref.watch(parseNovelQueryProvider),
  ),
  name: 'GetNovelByUrlProvider',
);

/// Retrieve novel from database by its url
class GetNovelByUrl {
  GetNovelByUrl({
    required AppDatabase database,
    required ParseNovelQuery parseNovelQuery,
  })  : _database = database,
        _parseNovelQuery = parseNovelQuery;

  final AppDatabase _database;
  final ParseNovelQuery _parseNovelQuery;

  Future<Either<Failure, NovelData>> execute(String url) {
    final query = _database.select(_database.novels).join([
      leftOuterJoin(
        _database.assets,
        _database.assets.id.equalsExp(_database.novels.coverId),
      ),
    ])
      ..where(_database.novels.url.equals(url));

    return _parseNovelQuery.execute(query);
  }
}
