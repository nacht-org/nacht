import 'dart:io';

import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/app_database.dart';

final deleteDownloadedChapter = Provider<DeleteDownloadedChapter>(
  (ref) => DeleteDownloadedChapter(
    database: ref.watch(databaseProvider),
  ),
  name: 'DeleteDownloadedChapterProvider',
);

class DeleteDownloadedChapter {
  const DeleteDownloadedChapter({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<void> call(int chapterId, int assetId) async {
    await _database.transaction(
      () async {
        await (_database.update(_database.chapters)
              ..where((tbl) => tbl.id.equals(chapterId)))
            .write(const ChaptersCompanion(content: Value(null)));

        final companion = AssetsCompanion(id: Value(assetId));
        final asset =
            await _database.delete(_database.assets).deleteReturning(companion);
        if (asset == null) return;

        if (asset.path != null) {
          final file = File(asset.path!);
          if (await file.exists()) {
            await File(asset.path!).delete();
          }
        }
      },
    );
  }
}
