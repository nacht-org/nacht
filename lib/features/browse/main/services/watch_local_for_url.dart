import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

import '../models/models.dart';

final watchLocalForUrlProvider = Provider<WatchLocalForUrl>(
  (ref) => WatchLocalForUrl(
    database: ref.watch(databaseProvider),
  ),
  name: "GetLocalForUrlProvider",
);

class WatchLocalForUrl with LoggerMixin {
  WatchLocalForUrl({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<FetchCardLocalInfo?> execute(String url) {
    log.fine("watching local for $url");

    final favorite = _database.novels.favourite;
    final query = _database.selectOnly(_database.novels)
      ..addColumns([favorite])
      ..where(_database.novels.url.equals(url));

    return query
        .map((row) => FetchCardLocalInfo(favorite: row.read(favorite) ?? false))
        .watchSingleOrNull();
  }
}
