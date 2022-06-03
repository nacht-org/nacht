import 'package:dartz/dartz.dart';

import 'package:nacht/core/failure.dart';
import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';

import '../../domain/domain.dart';

class UpdatesRepositoryImpl implements UpdatesRepository {
  UpdatesRepositoryImpl({
    required this.database,
  });

  final AppDatabase database;

  @override
  Future<Either<Failure, void>> addAll(Iterable<NewUpdate> updates) async {
    await database.batch((batch) {
      for (final update in updates) {
        batch.insert(database.updates, update.intoCompanion());
      }
    });

    return const Right(null);
  }

  @override
  Future<List<UpdateData>> getAll({required int count}) async {
    final query = database.select(database.updates).join([
      innerJoin(
        database.novels,
        database.novels.id.equalsExp(database.updates.novelId),
      ),
      innerJoin(
        database.chapters,
        database.chapters.id.equalsExp(database.updates.chapterId),
      ),
      innerJoin(
        database.volumes,
        database.volumes.id.equalsExp(database.chapters.volumeId),
      )
    ])
      ..where(database.novels.favourite.equals(true))
      ..limit(count)
      ..orderBy([OrderingTerm.desc(database.updates.updatedAt)]);

    final results = await query.get();

    return results.map((row) {
      final update = row.readTable(database.updates);
      final novel = row.readTable(database.novels);
      final chapter = row.readTable(database.chapters);
      final volume = row.readTable(database.volumes);

      return UpdateData.fromModel(
        update,
        NovelData.fromModel(novel),
        ChapterData.fromModel(chapter, VolumeData.fromModel(volume)),
      );
    }).toList();
  }
}
