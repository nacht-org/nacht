import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';

final watchChapterListProvider = Provider<WatchChapterList>(
  (ref) => WatchChapterList(
    database: ref.watch(databaseProvider),
  ),
  name: 'WatchChapterListProvider',
);

class WatchChapterList {
  WatchChapterList({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;
  Stream<List<ChapterData>> call(int novelId) {
    final query = _database.select(_database.chapters).join([
      leftOuterJoin(
        _database.volumes,
        _database.chapters.volumeId.equalsExp(_database.volumes.id),
      )
    ])
      ..where(_database.chapters.novelId.equals(novelId))
      ..orderBy([OrderingTerm.asc(_database.chapters.chapterIndex)]);

    final volumeMap = <int, VolumeData>{};
    return query.watch().map(
          (result) => result.map((row) {
            final chapter = row.readTable(_database.chapters);
            final volume = volumeMap.putIfAbsent(
              chapter.volumeId,
              () => VolumeData.fromModel(row.readTable(_database.volumes)),
            );

            return ChapterData.fromModel(chapter, volume);
          }).toList(),
        );
  }
}
