import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';
import 'package:workmanager/workmanager.dart';

class AppUpdateCancelAction with LoggerMixin implements NotificationAction {
  static const String id = 'AppUpdate.Cancel';

  @override
  Future<void> execute(
    ProviderContainer container,
    NotificationResponse response,
  ) async {
    Workmanager().cancelByTag(BackgroundTaskTag.appUpdate);
  }
}
