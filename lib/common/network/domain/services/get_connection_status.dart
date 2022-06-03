import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain.dart';

final getConnectionStatusProvider = Provider<GetConnectionStatus>(
  (ref) => GetConnectionStatus(),
  name: 'GetConnectionStatusProvider',
);

class GetConnectionStatus {
  final Connectivity connectivity = Connectivity();

  Future<NetworkConnectionData> execute() async {
    final result = await connectivity.checkConnectivity();
    return NetworkConnectionData.fromConnectivity(result);
  }
}
