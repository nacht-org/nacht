import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

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

  Future<Either<Failure, Download>> call(int chapterId, int orderIndex) async {
    final download = await _database.into(_database.downloads).insertReturning(
          DownloadsCompanion.insert(
            orderIndex: orderIndex,
            chapterId: chapterId,
            createdAt: DateTime.now(),
          ),
        );

    return Right(download);
  }
}
