import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nacht/features/release/notifications/notifications.dart';

import '../logger/logger.dart';
import 'notification_action.dart';

export 'notification_channel.dart';
export 'notification_handle.dart';
export 'notification_service.dart';
export 'notification_action.dart';

typedef RefRead = T Function<T>(ProviderListenable<T>);

final flutterLocalNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>(
        (ref) => FlutterLocalNotificationsPlugin());

Future<FlutterLocalNotificationsPlugin> initializeLocalNotificationsPlugin(
    RefRead read) async {
  final plugin = FlutterLocalNotificationsPlugin();
  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );

  await plugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
    onDidReceiveNotificationResponse: (response) =>
        onDidReceiveNotificationResponse(read, response),
  );

  return plugin;
}

Future<void> handleAppLaunchNotification(
  FlutterLocalNotificationsPlugin plugin,
  RefRead read,
) async {
  final notificationAppLaunchDetails =
      await plugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails != null &&
      notificationAppLaunchDetails.didNotificationLaunchApp &&
      notificationAppLaunchDetails.notificationResponse != null) {
    onDidReceiveNotificationResponse(
        read, notificationAppLaunchDetails.notificationResponse!);
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
  NotificationResponse response,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final container = ProviderContainer();
  await initializeLocalNotificationsPlugin(container.read);
  initializeLogger();

  switch (response.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      break;
    case NotificationResponseType.selectedNotificationAction:
      switch (response.actionId) {
        case AppUpdateDownloadAction.id:
          AppUpdateDownloadAction().execute(container.read, response);
          break;
        case AppUpdateCancelAction.id:
          AppUpdateCancelAction().execute(container.read, response);
          break;
        case VoidAction.id:
          break;
        default:
          throw Exception(
              'Action not registered in background: ${response.actionId}');
      }
      break;
  }
}

void onDidReceiveNotificationResponse(
  RefRead read,
  NotificationResponse response,
) {
  switch (response.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      break;
    case NotificationResponseType.selectedNotificationAction:
      switch (response.actionId) {
        case AppUpdateInstallAction.id:
          AppUpdateInstallAction().execute(read, response);
          break;
        case AppUpdateWhatsNewAction.id:
          AppUpdateWhatsNewAction().execute(read, response);
          break;
        case VoidAction.id:
          break;
        default:
          throw Exception(
              'Action not registered in foreground: ${response.actionId}');
      }
      break;
  }
}

abstract class Notification {
  const Notification();

  String get title;
  String get body;
  NotificationDetails? get notificationDetails;
  String? get payload => null;
}
