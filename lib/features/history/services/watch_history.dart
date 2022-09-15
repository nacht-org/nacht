import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';

final watchHistoryProvider = Provider<WatchHistory>(
  (ref) => WatchHistory(
    database: ref.watch(databaseProvider),
  ),
  name: "WatchHistoryProvider",
);

class WatchHistory {
  const WatchHistory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<List<HistoryData>> execute() {
    final query = _database.select(_database.readingHistories).join([
      leftOuterJoin(
        _database.chapters,
        _database.readingHistories.chapterId.equalsExp(_database.chapters.id),
      ),
      leftOuterJoin(
        _database.volumes,
        _database.chapters.volumeId.equalsExp(_database.volumes.id),
      ),
      leftOuterJoin(
        _database.novels,
        _database.chapters.novelId.equalsExp(_database.novels.id),
      ),
    ])
      ..orderBy([OrderingTerm.desc(_database.readingHistories.updatedAt)])
      ..groupBy([_database.novels.id]);

    return query.map((row) {
      final history = row.readTable(_database.readingHistories);
      final chapter = row.readTable(_database.chapters);
      final volume = row.readTable(_database.volumes);
      final novel = row.readTable(_database.novels);

      return HistoryData.fromModel(
        history,
        NovelData.fromModel(novel),
        ChapterData.fromModel(
          chapter,
          VolumeData.fromModel(volume),
        ),
      );
    }).watch();
  }
}
