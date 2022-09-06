import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';

import '../models/models.dart';

final watchUpdatesProvider = Provider<WatchUpdates>(
  (ref) => WatchUpdates(
    database: ref.watch(databaseProvider),
  ),
  name: 'WatchUpdatesProvider',
);

class WatchUpdates {
  WatchUpdates({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<List<UpdateData>> execute() {
    final query = _database.select(_database.updates).join([
      innerJoin(
        _database.novels,
        _database.novels.id.equalsExp(_database.updates.novelId),
      ),
      innerJoin(
        _database.chapters,
        _database.chapters.id.equalsExp(_database.updates.chapterId),
      ),
      innerJoin(
        _database.volumes,
        _database.volumes.id.equalsExp(_database.chapters.volumeId),
      )
    ])
      ..where(_database.novels.favourite.equals(true))
      ..limit(100)
      ..orderBy([OrderingTerm.desc(_database.updates.updatedAt)]);

    final stream = query.watch();
    return stream.map(
      (event) => event.map((row) {
        final update = row.readTable(_database.updates);
        final novel = row.readTable(_database.novels);
        final chapter = row.readTable(_database.chapters);
        final volume = row.readTable(_database.volumes);

        return UpdateData.fromModel(
          update,
          NovelData.fromModel(novel),
          ChapterData.fromModel(chapter, VolumeData.fromModel(volume)),
        );
      }).toList(),
    );
  }
}
