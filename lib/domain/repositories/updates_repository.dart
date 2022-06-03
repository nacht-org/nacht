import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/database/database.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

final updatesRepositoryProvider = Provider<UpdatesRepository>(
  (ref) => UpdatesRepositoryImpl(
    database: ref.watch(databaseProvider),
  ),
  name: 'UpdatesRepositoryProvider',
);

abstract class UpdatesRepository {
  Future<Either<Failure, void>> addAll(Iterable<NewUpdate> updates);
  Future<List<UpdateData>> getAll({required int count});
}
