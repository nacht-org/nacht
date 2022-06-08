import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/common/network/domain/entities/network_connection_data.dart';

void main() {
  const map = {
    ConnectivityResult.wifi:
        NetworkConnectionData(type: NetworkConnectionType.wifi),
    ConnectivityResult.mobile:
        NetworkConnectionData(type: NetworkConnectionType.mobile),
    ConnectivityResult.bluetooth:
        NetworkConnectionData(type: NetworkConnectionType.none),
    ConnectivityResult.ethernet:
        NetworkConnectionData(type: NetworkConnectionType.none),
    ConnectivityResult.none:
        NetworkConnectionData(type: NetworkConnectionType.none),
  };

  test('should create NetworkConnectionData from ConnectivityResult', () {
    for (final entry in map.entries) {
      final result = NetworkConnectionData.fromConnectivity(entry.key);
      expect(result, entry.value);
    }
  });
}
