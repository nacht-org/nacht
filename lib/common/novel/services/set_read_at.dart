import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';

import '../entities/chapter_data.dart';

final setReadAtProvider = Provider<SetReadAt>(
  (ref) => SetReadAt(
    database: ref.watch(databaseProvider),
  ),
  name: "SetReadAtProvider",
);

class SetReadAt {
  SetReadAt({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;

  Future<Failure?> execute(Iterable<ChapterData> chapters, bool isRead) async {
    final readAt = isRead ? DateTime.now() : null;
    await _database.batch((batch) {
      for (final chapter in chapters) {
        final companion = ChaptersCompanion(
          readAt: Value(readAt),
        );

        batch.update<Chapters, Chapter>(
          _database.chapters,
          companion,
          where: (tbl) => tbl.id.equals(chapter.id),
        );
      }
    });

    return null;
  }
}
