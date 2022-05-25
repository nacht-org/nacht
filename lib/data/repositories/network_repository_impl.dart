import 'package:nacht/domain/entities/network/network_connection_data.dart';
import 'package:nacht/domain/repositories/network_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../core/core.dart';

class NetworkRepositoryImpl with LoggerMixin implements NetworkRepository {
  NetworkRepositoryImpl();

  final Connectivity connectivity = Connectivity();

  @override
  Future<NetworkConnectionType> getConnectionStatus() async {
    final result = await connectivity.checkConnectivity();
    return NetworkConnectionData.fromConnectivity(result).type;
  }

  @override
  Future<bool> isConnectionAvailable() async {
    final connection = await getConnectionStatus();
    log.info(
        'checking whether device is connected to the intenet => $connection.');

    switch (connection) {
      case NetworkConnectionType.none:
        return false;
      case NetworkConnectionType.mobile:
        return true;
      case NetworkConnectionType.wifi:
        return true;
    }
  }
}
