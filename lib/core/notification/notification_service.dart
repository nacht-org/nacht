import 'package:flutter/material.dart' hide Notification;
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

  FlutterLocalNotificationsPlugin plugin;

  NotificationHandle getHandle({int? id}) {
    return NotificationHandle(plugin, id ?? UniqueKey().hashCode);
  }

  Future<void> show(Notification notification) async {
    await getHandle().show(notification);
  }

  Future<void> cancel(int id) async {
    return plugin.cancel(id);
  }
}
