import 'package:chapturn/domain/entities/network/network_connection.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../core/core.dart';
import '../../domain/mapper.dart';

class NetworkRepositoryImpl with LoggerMixin implements NetworkRepository {
  NetworkRepositoryImpl(this._connectionMapper);

  final Mapper<ConnectivityResult, NetworkConnection> _connectionMapper;
  final Connectivity connectivity = Connectivity();

  @override
  Future<NetworkConnection> getConnectionStatus() async {
    final result = await connectivity.checkConnectivity();
    return _connectionMapper.from(result);
  }

  @override
  Future<bool> isConnectionAvailable() async {
    final connection = await getConnectionStatus();
    log.info(
        'checking whether device is connected to the intenet => $connection.');

    switch (connection) {
      case NetworkConnection.none:
        return false;
      case NetworkConnection.mobile:
        return true;
      case NetworkConnection.wifi:
        return true;
    }
  }
}
