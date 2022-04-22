import 'package:chapturn/domain/entities/network/network_connection.dart';

abstract class NetworkRepository {
  Future<NetworkConnection> getConnectionStatus();
  Future<bool> isConnectionAvailable();
}
