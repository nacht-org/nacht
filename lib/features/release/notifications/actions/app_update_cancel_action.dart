import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';
import 'package:workmanager/workmanager.dart';

class AppUpdateCancelAction with LoggerMixin implements NotificationActionTask {
  static const String id = 'AppUpdate.Cancel';

  @override
  Future<void> execute(
    ProviderContainer container,
    NotificationResponse response,
  ) async {
    await Workmanager().cancelByTag(BackgroundTaskTag.updateApp.name);

    final flutterLocalNotificationsPlugin =
        container.read(flutterLocalNotificationsPluginProvider);
    if (response.id != null) {
      await flutterLocalNotificationsPlugin.cancel(response.id!);
    }

    // Workaround to makre sure that update is cancelled
    await Workmanager().cancelByTag(BackgroundTaskTag.updateApp.name);
  }
}
