import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain.dart';

final updatesServiceProvider = Provider<UpdatesService>(
  (ref) => UpdatesService(
    updatesRepository: ref.watch(updatesRepositoryProvider),
  ),
  name: 'UpdatesServiceProvider',
);

class UpdatesService {
  UpdatesService({
    required UpdatesRepository updatesRepository,
  }) : _updatesRepository = updatesRepository;

  final UpdatesRepository _updatesRepository;

  Future<List<UpdateData>> getUpdates() {
    // TODO: test getUpdates
    return _updatesRepository.getAll(count: 100);
  }
}
