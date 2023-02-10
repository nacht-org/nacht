import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

final removeAllDownloadsProvider = Provider<RemoveAllDownloads>(
  (ref) => RemoveAllDownloads(
    database: ref.watch(databaseProvider),
  ),
  name: 'RemoveAllDownloadsProvider',
);

class RemoveAllDownloads {
  const RemoveAllDownloads({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> call() async {
    await _database.delete(_database.downloads).go();
  }
}
