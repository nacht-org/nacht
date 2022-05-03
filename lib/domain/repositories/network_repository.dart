import 'package:chapturn/domain/entities/network/network_connection_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';

final networkRepositoryProvider = Provider<NetworkRepository>(
  (ref) => NetworkRepositoryImpl(),
  name: 'NetworkRepositoryService',
);

abstract class NetworkRepository {
  Future<NetworkConnectionType> getConnectionStatus();
  Future<bool> isConnectionAvailable();
}
