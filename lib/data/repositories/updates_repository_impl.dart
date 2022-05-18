import 'package:dartz/dartz.dart';

import 'package:chapturn/data/datasources/local/database.dart';

import 'package:chapturn/core/failure.dart';

import '../../domain/domain.dart';

class UpdatesRepositoryImpl implements UpdatesRepository {
  UpdatesRepositoryImpl({
    required this.database,
  });

  final AppDatabase database;

  @override
  Future<Either<Failure, void>> addAll(List<NewUpdate> updates) async {
    await database.batch((batch) {
      for (final update in updates) {
        batch.insert(database.updates, update.intoCompanion());
      }
    });

    return const Right(null);
  }
}
