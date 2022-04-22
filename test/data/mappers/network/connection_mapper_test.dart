import 'package:chapturn/data/mappers/network/connection_mapper.dart';
import 'package:chapturn/domain/entities/network/network_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../mapper_helper.dart';

void main() {
  mapperGroup(
    name: 'ConnectionToConnectivityMapper',
    mapper: ConnectionToConnectivityMapper(),
    test: (mapper) {
      mapperTest(
        'NetworkConnection.none',
        'ConnectivityResult.none',
        from: NetworkConnection.none,
        to: ConnectivityResult.none,
        mapper: mapper,
      );
      mapperTest(
        'NetworkConnection.mobile',
        'ConnectivityResult.mobile',
        from: NetworkConnection.mobile,
        to: ConnectivityResult.mobile,
        mapper: mapper,
      );
      mapperTest(
        'NetworkConnection.wifi',
        'ConnectivityResult.wifi',
        from: NetworkConnection.wifi,
        to: ConnectivityResult.wifi,
        mapper: mapper,
      );
    },
  );

  mapperGroup(
    name: 'ConnectivityToConnectionMapper',
    mapper: ConnectivityToConnectionMapper(),
    test: (mapper) {
      mapperTest(
        'ConnectivityResult.none',
        'NetworkConnection.none',
        from: ConnectivityResult.none,
        to: NetworkConnection.none,
        mapper: mapper,
      );
      mapperTest(
        'ConnectivityResult.mobile',
        'NetworkConnection.mobile',
        from: ConnectivityResult.mobile,
        to: NetworkConnection.mobile,
        mapper: mapper,
      );
      mapperTest(
        'ConnectivityResult.wifi',
        'NetworkConnection.wifi',
        from: ConnectivityResult.wifi,
        to: NetworkConnection.wifi,
        mapper: mapper,
      );
    },
  );
}
