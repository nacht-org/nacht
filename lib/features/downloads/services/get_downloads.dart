import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/app_database.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';

final getDownloadsProvider = Provider<GetDownloads>(
  (ref) => GetDownloads(
    database: ref.watch(databaseProvider),
  ),
  name: 'GetDownloadsProvider',
);

class GetDownloads {
  const GetDownloads({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, List<DownloadData>>> call() async {
    final query = _database.select(_database.downloads).join([
      leftOuterJoin(
        _database.chapters,
        _database.chapters.id.equalsExp(_database.downloads.chapterId),
      ),
      leftOuterJoin(
        _database.volumes,
        _database.volumes.id.equalsExp(_database.chapters.volumeId),
      ),
    ])
      ..orderBy([
        OrderingTerm.asc(_database.downloads.orderIndex),
      ]);

    final results = await query.get();

    return Right(results.map((result) {
      final volume = result.readTable(_database.volumes);
      final chapter = result.readTable(_database.chapters);
      final download = result.readTable(_database.downloads);

      return DownloadData.fromModel(
        download,
        ChapterData.fromModel(chapter, VolumeData.fromModel(volume)),
      );
    }).toList());
  }
}
