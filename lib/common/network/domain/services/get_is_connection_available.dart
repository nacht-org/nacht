import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain.dart';

final getIsConnectionAvailableProvider = Provider<GetIsConnectionAvailable>(
  (ref) => GetIsConnectionAvailable(
    getConnectionStatus: ref.watch(getConnectionStatusProvider),
  ),
  name: 'GetIsConnectionAvailableProvider',
);

class GetIsConnectionAvailable {
  GetIsConnectionAvailable({
    required GetConnectionStatus getConnectionStatus,
  }) : _getConnectionStatus = getConnectionStatus;

  final GetConnectionStatus _getConnectionStatus;

  Future<bool> execute() async {
    final connectivity = await _getConnectionStatus.execute();

    switch (connectivity) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.none:
        return false;
    }
  }
}
