import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_connection_data.freezed.dart';

enum NetworkConnectionType {
  none,
  mobile,
  wifi,
}

@freezed
class NetworkConnectionData with _$NetworkConnectionData {
  const factory NetworkConnectionData({
    required NetworkConnectionType type,
  }) = _NetworkConnectionData;

  factory NetworkConnectionData.fromConnectivity(
    ConnectivityResult connectivityResult,
  ) {
    NetworkConnectionType type;
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        type = NetworkConnectionType.wifi;
        break;
      case ConnectivityResult.mobile:
        type = NetworkConnectionType.mobile;
        break;
      default:
        type = NetworkConnectionType.none;
        break;
    }

    return NetworkConnectionData(type: type);
  }

  const NetworkConnectionData._();
}
