import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';

final watchHistoryProvider = Provider<WatchHistory>(
  (ref) => WatchHistory(
    database: ref.watch(databaseProvider),
  ),
  name: "WatchHistoryProvider",
);

class WatchHistory {
  const WatchHistory({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Stream<List<HistoryData>> execute() {
    final readingHistories = _database.alias(_database.readingHistories, "h");
    final chapters = _database.alias(_database.chapters, "c");
    final novels = _database.alias(_database.novels, "n");
    final volumes = _database.alias(_database.volumes, "v");

    final historyColumns = _database.readingHistories.$columns
        .map((column) => column.name)
        .join(", ");

    final columns = [
      buildSelectColumns(readingHistories.$columns),
      buildSelectColumns(chapters.$columns),
      buildSelectColumns(novels.$columns),
      buildSelectColumns(volumes.$columns),
    ].join(", ");

    final query = _database.customSelect(
        "SELECT $columns FROM "
        "(SELECT $historyColumns, ROW_NUMBER() OVER (PARTITION BY novel_id ORDER BY updated_at DESC) ranked_order FROM reading_histories) h "
        "LEFT JOIN chapters c ON h.chapter_id = c.id "
        "LEFT JOIN novels n ON c.novel_id = n.id "
        "LEFT JOIN volumes v ON c.volume_id = v.id "
        "WHERE h.ranked_order = 1 "
        "ORDER BY h.updated_at DESC",
        readsFrom: {
          _database.readingHistories,
          _database.chapters,
          _database.volumes,
          _database.novels,
        });

    return query.map((row) {
      final history = readingHistories.map(row.data,
          tablePrefix: readingHistories.aliasedName);
      final chapter = chapters.map(row.data, tablePrefix: chapters.aliasedName);
      final volume = volumes.map(row.data, tablePrefix: volumes.aliasedName);
      final novel = novels.map(row.data, tablePrefix: novels.aliasedName);

      return HistoryData.fromModel(
        history,
        NovelData.fromModel(novel),
        ChapterData.fromModel(
          chapter,
          VolumeData.fromModel(volume),
        ),
      );
    }).watch();
  }
}

String buildSelectColumns(List<GeneratedColumn> columns) {
  return columns
      .map((column) =>
          "${column.tableName}.${column.name} AS '${column.tableName}.${column.name}'")
      .join(", ");
}
