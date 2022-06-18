import 'package:nacht/common/common.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Used with connectivity check to indicate the lack of usable connection
///
/// This can also be used when connection type is [ConnectivityResult.mobile]
/// depending on the use preferences.
class NoNetworkConnection extends NetworkFailure {
  const NoNetworkConnection() : super('No network connection');
}
