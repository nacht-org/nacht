import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification.dart';

abstract class NotificationActionTask {
  Future<void> execute(
    RefRead read,
    NotificationResponse response,
  );
}

class NotificationAction {
  const NotificationAction({
    required this.android,
  });

  final AndroidNotificationAction android;

  static NotificationAction simple(
    String id,
    String title, {
    bool cancelNotification = true,
    bool showsUserInterface = false,
  }) {
    return NotificationAction(
      android: AndroidNotificationAction(
        id,
        title,
        cancelNotification: cancelNotification,
        showsUserInterface: showsUserInterface,
      ),
    );
  }
}

class VoidAction {
  static const String id = 'void';
}
