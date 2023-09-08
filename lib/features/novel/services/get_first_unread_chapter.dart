import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

import '../failures/failures.dart';
import '../models/models.dart';

final getFirstUnreadChapterProvider = Provider<GetFirstUnreadChapter>(
  (ref) => GetFirstUnreadChapter(
    database: ref.watch(databaseProvider),
  ),
  name: 'GetFirstUnreadChapterProvider',
);

class GetFirstUnreadChapter {
  GetFirstUnreadChapter({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, ChapterData>> execute(int novelId) async {
    final query = _database.select(_database.chapters).join([
      leftOuterJoin(
        _database.volumes,
        _database.volumes.id.equalsExp(_database.chapters.volumeId),
      ),
      leftOuterJoin(
        _database.novels,
        _database.novels.id.equalsExp(_database.chapters.novelId),
        useColumns: false,
      )
    ])
      ..where(_database.novels.id.equals(novelId) &
          _database.chapters.readAt.isNull())
      ..orderBy([OrderingTerm.asc(_database.chapters.chapterIndex)])
      ..limit(1);

    final row = await query.getSingleOrNull();
    if (row == null) {
      return const Left(AllChaptersRead());
    }

    final chapter = row.readTable(_database.chapters);
    final volume = row.readTable(_database.volumes);

    return Right(
      ChapterData.fromModel(chapter, VolumeData.fromModel(volume)),
    );
  }
}
