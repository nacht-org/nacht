import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getConnectionStatusProvider = Provider<GetConnectionStatus>(
  (ref) => GetConnectionStatus(),
  name: 'GetConnectionStatusProvider',
);

class GetConnectionStatus {
  final Connectivity connectivity = Connectivity();

  Future<ConnectivityResult> execute() async {
    return await connectivity.checkConnectivity();
  }
}
