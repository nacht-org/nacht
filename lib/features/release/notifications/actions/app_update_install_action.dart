import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';

class AppUpdateInstallAction with LoggerMixin implements NotificationAction {
  static const String id = 'AppUpdate.Install';

  @override
  Future<void> execute(
    ProviderContainer container,
    NotificationResponse response,
  ) async {
    log.info('install ${response.payload}');
  }
}
