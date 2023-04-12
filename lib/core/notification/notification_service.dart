import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

final notificationServiceProvider = Provider(
  (ref) => NotificationService(
    plugin: ref.watch(flutterLocalNotificationsPluginProvider),
  ),
);

class NotificationService {
  NotificationService({
    required this.plugin,
  });

  int counter = 0;
  FlutterLocalNotificationsPlugin plugin;

  NotificationHandle getHandle({int? id}) {
    return NotificationHandle(plugin, id ?? counter++);
  }

  Future<void> show(Notification notification) async {
    await getHandle().show(notification);
  }
}
