import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/app_database.dart';
import 'package:nacht/features/features.dart';

final insertMultipleDownloadsProvider = Provider<InsertMultipleDownloads>(
  (ref) => InsertMultipleDownloads(
    database: ref.watch(databaseProvider),
  ),
  name: 'InsertMultipleDownloadsProvider',
);

class InsertMultipleDownloads {
  const InsertMultipleDownloads({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, List<DownloadData>>> call(
    Iterable<DownloadRelatedData> data,
    int orderIndex,
  ) async {
    final downloads = <DownloadData>[];

    // FIXME: This transaction can throw an error and should be handled.
    int runningIndex = orderIndex;
    await _database.transaction(() async {
      for (final related in data) {
        final model = await _database.into(_database.downloads).insertReturning(
              DownloadsCompanion.insert(
                orderIndex: runningIndex,
                chapterId: related.chapterId,
                createdAt: DateTime.now(),
              ),
            );

        final download = DownloadData.fromModel(model, related);
        downloads.add(download);

        runningIndex += 1;
      }
    });

    return Right(downloads);
  }
}
