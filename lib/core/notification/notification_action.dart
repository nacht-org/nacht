import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class NotificationActionTask {
  Future<void> execute(
    ProviderContainer container,
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
  }) {
    return NotificationAction(
      android: AndroidNotificationAction(
        id,
        title,
        cancelNotification: cancelNotification,
      ),
    );
  }
}

class VoidAction {
  static const String id = 'void';
}
