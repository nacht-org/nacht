import 'package:nacht/common/common.dart';

/// Used with connectivity check to indicate the lack of usable connection
/// 
/// This can also be used when connection type is [NetworkConnectionType.mobile]
/// depending on the use preferences.
/// 
/// See also:
/// - [NetworkConnectionData]
class ConnectionNotAvailable extends NetworkFailure {
  const ConnectionNotAvailable() : super('Connection not available');
}
