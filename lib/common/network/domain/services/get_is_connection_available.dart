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
    final connection = await _getConnectionStatus.execute();

    switch (connection.type) {
      case NetworkConnectionType.none:
        return false;
      case NetworkConnectionType.mobile:
        return true;
      case NetworkConnectionType.wifi:
        return true;
    }
  }
}
