import 'package:dartz/dartz.dart';

import 'package:chapturn/data/datasources/local/database.dart';

import 'package:chapturn/core/failure.dart';
import 'package:drift/drift.dart';

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
    ])
      ..where(database.novels.favourite.equals(true))
      ..limit(count)
      ..orderBy([OrderingTerm.desc(database.updates.updatedAt)]);

    final results = await query.get();

    return results.map((row) {
      final update = row.readTable(database.updates);
      final novel = row.readTable(database.novels);
      final chapter = row.readTable(database.chapters);

      return UpdateData.fromModel(
        update,
        NovelData.fromModel(novel),
        ChapterData.fromModel(chapter),
      );
    }).toList();
  }
}
