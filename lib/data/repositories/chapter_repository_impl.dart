import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../datasources/local/database.dart';

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
          id: Value(chapter.id),
          readAt: Value(readAt),
        );

        batch.update(database.chapters, companion);
      }
    });

    return const Right(null);
  }
}
