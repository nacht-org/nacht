import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/app_database.dart';

final removeDownloadProvider = Provider<RemoveDownload>(
  (ref) => RemoveDownload(
    database: ref.watch(databaseProvider),
  ),
  name: 'RemoveDownloadByIdProvider',
);

class RemoveDownload {
  RemoveDownload({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Either<Failure, void>> call(int downloadId) async {
    final query = _database.delete(_database.downloads)
      ..where((tbl) => tbl.id.equals(downloadId));

    await query.go();
    return const Right(null);
  }
}
