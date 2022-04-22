import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/entities/network/network_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionToConnectivityMapper
    implements Mapper<NetworkConnection, ConnectivityResult> {
  @override
  ConnectivityResult map(NetworkConnection entity) {
    switch (entity) {
      case NetworkConnection.none:
        return ConnectivityResult.none;
      case NetworkConnection.mobile:
        return ConnectivityResult.mobile;
      case NetworkConnection.wifi:
        return ConnectivityResult.wifi;
    }
  }
}

class ConnectivityToConnectionMapper
    implements Mapper<ConnectivityResult, NetworkConnection> {
  @override
  NetworkConnection map(ConnectivityResult model) {
    switch (model) {
      case ConnectivityResult.wifi:
        return NetworkConnection.wifi;
      case ConnectivityResult.mobile:
        return NetworkConnection.mobile;
      default:
        return NetworkConnection.none;
    }
  }
}
