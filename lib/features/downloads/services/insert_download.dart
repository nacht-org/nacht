import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/features/features.dart';

final insertDownloadProvider = Provider<InsertDownload>(
  (ref) => InsertDownload(
    database: ref.watch(databaseProvider),
  ),
  name: 'InsertDownloadProvider',
);

class InsertDownload {
  const InsertDownload({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, DownloadData>> call(
    DownloadRelatedData related,
    int orderIndex,
  ) async {
    final model = await _database.into(_database.downloads).insertReturning(
          DownloadsCompanion.insert(
            orderIndex: orderIndex,
            chapterId: related.chapterId,
            createdAt: DateTime.now(),
          ),
        );

    final download = DownloadData.fromModel(model, related);
    return Right(download);
  }
}
