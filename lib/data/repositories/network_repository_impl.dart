import 'package:chapturn/domain/entities/network/network_connection.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import '../../domain/mapper.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  NetworkRepositoryImpl(this._connectionMapper);

  final Mapper<ConnectivityResult, NetworkConnection> _connectionMapper;
  final Connectivity connectivity = Connectivity();

  final _log = Logger('NetworkRepositoryImpl');

  @override
  Future<NetworkConnection> getConnectionStatus() async {
    final result = await connectivity.checkConnectivity();
    return _connectionMapper.map(result);
  }

  @override
  Future<bool> isConnectionAvailable() async {
    final connection = await getConnectionStatus();
    _log.info('Connection status: $connection.');

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
