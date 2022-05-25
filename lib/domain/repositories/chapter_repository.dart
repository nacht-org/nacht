import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

final chapterRepositoryProvider = Provider<ChapterRepository>(
  (ref) => ChapterRepositoryImpl(
    database: ref.watch(databaseProvider),
  ),
  name: 'ChapterRepositoryProvider',
);

abstract class ChapterRepository {
  Future<Either<Failure, void>> setReadAt(
      List<ChapterData> chapters, DateTime? readAt);
}
