import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../data.dart';

class ChapterRepositoryImpl implements ChapterRepository {
  ChapterRepositoryImpl({
    required this.database,
  });

  final AppDatabase database;

  @override
  Future<Either<Failure, void>> setReadAt(
    List<ChapterData> chapters,
    DateTime? readAt,
  ) async {
    await database.batch((batch) {
      for (final chapter in chapters) {
        final companion = ChaptersCompanion(
          readAt: Value(readAt),
        );

        batch.update<Chapters, Chapter>(
          database.chapters,
          companion,
          where: (tbl) => tbl.id.equals(chapter.id),
        );
      }
    });

    return const Right(null);
  }
}
