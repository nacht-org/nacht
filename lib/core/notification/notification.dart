import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nacht/features/release/notifications/notifications.dart';

import '../logger/logger.dart';

export 'notification_channel.dart';
export 'notification_handle.dart';
export 'notification_service.dart';
export 'notification_action.dart';

final flutterLocalNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>(
        (ref) => FlutterLocalNotificationsPlugin());

Future<void> initializeLocalNotificationsPlugin() async {
  final plugin = FlutterLocalNotificationsPlugin();
  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );

  await plugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
  NotificationResponse response,
) async {
  final container = ProviderContainer();
  await initializeLocalNotificationsPlugin();
  initializeLogger();

  switch (response.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      break;
    case NotificationResponseType.selectedNotificationAction:
      switch (response.actionId) {
        case AppUpdateDownloadAction.id:
          AppUpdateDownloadAction().execute(container, response);
          break;
        case AppUpdateCancelAction.id:
          AppUpdateCancelAction().execute(container, response);
          break;
        case AppUpdateInstallAction.id:
          AppUpdateInstallAction().execute(container, response);
          break;
        default:
          break;
      }
      break;
  }
}

void onDidReceiveNotificationResponse(
  NotificationResponse response,
) {
  print(response.input);
}

abstract class Notification {
  const Notification();

  String get title;
  String get body;
  NotificationDetails? get notificationDetails;
  String? get payload => null;
}
