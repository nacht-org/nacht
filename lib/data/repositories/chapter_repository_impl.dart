import 'package:nacht/core/failure.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

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
