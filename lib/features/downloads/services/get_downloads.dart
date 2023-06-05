import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/app_database.dart';

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
    final downloads = _database.alias(_database.downloads, 'd');

    final columns = [
      buildSelectColumns(downloads.$columns),
      "n.id as novelId",
      "n.title as novelTitle",
      "n.url as novelUrl",
      "c.id as chapterId",
      'c.title as chapterTitle',
      'c.url as chapterUrl',
      'c.volume_id as volumeId',
    ].join(", ");

    final query = _database.customSelect(
      "SELECT $columns FROM downloads d "
      "LEFT JOIN chapters c ON d.chapter_id = c.id "
      "LEFT JOIN novels n ON c.novel_id = n.id "
      "ORDER BY d.order_index ASC",
      readsFrom: {
        _database.downloads,
        _database.chapters,
        _database.novels,
      },
    );

    final results = await query.get();

    return Right(results.map((row) {
      final download =
          downloads.map(row.data, tablePrefix: downloads.aliasedName);

      final novelId = row.read<int>('novelId');
      final novelTitle = row.read<String>('novelTitle');
      final novelUrl = row.read<String>('novelUrl');
      final chapterId = row.read<int>('chapterId');
      final chapterTitle = row.read<String>('chapterTitle');
      final chapterUrl = row.read<String>('chapterUrl');
      final volumeId = row.read<int>('volumeId');

      final related = DownloadRelatedData(
        novelId: novelId,
        novelTitle: novelTitle,
        novelUrl: novelUrl,
        chapterId: chapterId,
        chapterTitle: chapterTitle,
        chapterUrl: chapterUrl,
        volumeId: volumeId,
      );

      return DownloadData.fromModel(download, related);
    }).toList());
  }
}

String buildSelectColumns(List<GeneratedColumn> columns) {
  return columns
      .map((column) =>
          "${column.tableName}.${column.name} AS '${column.tableName}.${column.name}'")
      .join(", ");
}
