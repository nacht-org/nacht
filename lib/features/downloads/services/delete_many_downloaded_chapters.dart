import 'dart:io';

import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';

final deleteManyDownloadedChaptersProvider =
    Provider.autoDispose<DeleteManyDownloadedChapters>(
  (ref) => DeleteManyDownloadedChapters(
    database: ref.watch(databaseProvider),
  ),
  name: 'DeleteManyDownloadedChaptersProvider',
);

class DeleteManyDownloadedChapters {
  const DeleteManyDownloadedChapters({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> call(Iterable<ChapterData> chapters) async {
    final chapterIds = chapters.map((e) => e.id);
    final assetIds = chapters.map((e) => e.content).whereType<int>();

    _database.transaction(() async {
      await (_database.update(_database.chapters)
            ..where((tbl) => tbl.id.isIn(chapterIds)))
          .write(const ChaptersCompanion(content: Value(null)));

      final assets = await (_database.select(_database.assets)
            ..where((tbl) => tbl.id.isIn(assetIds)))
          .get();

      for (final asset in assets) {
        await File(asset.path!).delete();
      }

      await (_database.delete(_database.assets)
            ..where((tbl) => tbl.id.isIn(assetIds)))
          .go();
    });
  }
}
