import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/database/database.dart';

final watchTagsProvider = Provider<WatchTags>(
  (ref) => WatchTags(
    database: ref.watch(databaseProvider),
  ),
  name: 'WatchTagsProvider',
);

class WatchTags {
  WatchTags({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<List<MetaEntryData>> execute(int novelId) {
    final query = _database.select(_database.metaEntries)
      ..where((tbl) => tbl.novelId.equals(novelId))
      ..where((tbl) => tbl.name.equals('subject'));

    return query.map(MetaEntryData.fromModel).watch();
  }
}
