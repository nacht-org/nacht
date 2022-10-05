import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

import '../models/models.dart';

final getChaptersProvider = Provider<GetChapters>(
  (ref) => GetChapters(
    database: ref.watch(databaseProvider),
  ),
);

class GetChapters {
  GetChapters({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<List<ChapterData>> execute(int novelId) async {
    final query = _database.select(_database.chapters).join([
      leftOuterJoin(
        _database.volumes,
        _database.chapters.volumeId.equalsExp(_database.volumes.id),
      )
    ])
      ..where(_database.chapters.novelId.equals(novelId))
      ..orderBy([OrderingTerm.asc(_database.chapters.chapterIndex)]);

    final results = await query.get();

    final volumeMap = <int, VolumeData>{};
    return results.map((row) {
      final chapter = row.readTable(_database.chapters);
      final volume = volumeMap.putIfAbsent(
        chapter.volumeId,
        () => VolumeData.fromModel(row.readTable(_database.volumes)),
      );

      return ChapterData.fromModel(chapter, volume);
    }).toList();
  }
}
