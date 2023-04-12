import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';

class NotificationHandle {
  final int id;
  final FlutterLocalNotificationsPlugin plugin;

  const NotificationHandle(this.plugin, this.id);

  Future<void> show(Notification notification) async {
    await plugin.show(
      id,
      notification.title,
      notification.body,
      notification.notificationDetails,
      payload: notification.payload,
    );
  }
}
