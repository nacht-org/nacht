import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/common/network/domain/entities/network_connection_data.dart';

void main() {
  const map = {
    ConnectivityResult.wifi: NetworkConnectionType.wifi,
    ConnectivityResult.mobile: NetworkConnectionType.mobile,
    ConnectivityResult.bluetooth: NetworkConnectionType.none,
    ConnectivityResult.ethernet: NetworkConnectionType.none,
    ConnectivityResult.none: NetworkConnectionType.none,
  };

  test('should create NetworkConnectionData from ConnectivityResult', () {
    for (final entry in map.entries) {
      final result = NetworkConnectionType.fromConnectivity(entry.key);
      expect(result, entry.value);
    }
  });
}
