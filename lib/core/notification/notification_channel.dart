import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_action.dart';

class NotificationGroup {
  const NotificationGroup({
    required this.key,
    required this.android,
  });

  final String key;
  final AndroidNotificationChannelGroup android;

  String get id => android.id;

  /// Create channel id from group id and [value]
  String channelId(String value) {
    return '$id-$value';
  }
}

/// Defines notification groups used by this application
class NotificationGroups {
  static const updates = NotificationGroup(
    key: 'org.nacht.UPDATES',
    android: AndroidNotificationChannelGroup('updates', 'Updates'),
  );

  static const downloader = NotificationGroup(
    key: 'org.nacht.DOWNLOADER',
    android: AndroidNotificationChannelGroup('downloader', 'Downloader'),
  );

  static const List<NotificationGroup> all = [updates, downloader];

  static void createAll() {
    final androidPlugin = FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;
    for (final group in all) {
      androidPlugin.createNotificationChannelGroup(group.android);
    }
  }
}

class NotificationChannel {
  const NotificationChannel({
    this.group,
    required this.android,
  });

  final NotificationGroup? group;
  final AndroidNotificationChannel android;

  NotificationDetails simple({
    bool ongoing = false,
    List<NotificationAction>? actions,
  }) {
    return NotificationDetails(
      android: android.details(
        ongoing: ongoing,
        actions: actions?.map((action) => action.android).toList(),
      ),
    );
  }

  NotificationDetails progress({
    int progress = 0,
    int maxProgress = 0,
    bool indeterminate = false,
    List<NotificationAction>? actions,
  }) {
    return NotificationDetails(
      android: android.details(
        ongoing: true,
        showProgress: true,
        progress: progress,
        maxProgress: maxProgress,
        indeterminate: indeterminate,
        actions: actions?.map((action) => action.android).toList(),
        category: AndroidNotificationCategory.progress,
        groupKey: group?.key,
      ),
    );
  }
}

extension ChannelIntoDetails on AndroidNotificationChannel {
  AndroidNotificationDetails details({
    bool showProgress = false,
    bool ongoing = false,
    int progress = 0,
    int maxProgress = 0,
    bool indeterminate = false,
    List<AndroidNotificationAction>? actions,
    AndroidNotificationCategory? category,
    String? groupKey,
  }) {
    return AndroidNotificationDetails(
      id,
      name,
      channelDescription: description,
      groupKey: groupKey,
      importance: importance,
      playSound: playSound,
      enableVibration: enableVibration,
      enableLights: enableLights,
      sound: sound,
      ledColor: ledColor,
      vibrationPattern: vibrationPattern,
      showProgress: showProgress,
      ongoing: ongoing,
      progress: progress,
      maxProgress: maxProgress,
      actions: actions,
      category: category,
    );
  }
}

/// Defines notification channels used by this application
abstract class NotificationChannels {
  static NotificationChannel get updatesApp {
    const group = NotificationGroups.updates;
    return NotificationChannel(
      group: group,
      android: AndroidNotificationChannel(
        group.channelId('app'),
        'App updates',
        groupId: group.id,
      ),
    );
  }

  static NotificationChannel get downloaderProgress {
    const group = NotificationGroups.downloader;
    return NotificationChannel(
      group: group,
      android: AndroidNotificationChannel(
        group.channelId('progress'),
        'Progress',
        groupId: group.id,
        playSound: false,
        importance: Importance.defaultImportance,
        enableVibration: false,
        showBadge: false,
      ),
    );
  }

  static List<NotificationChannel> get all {
    return [
      updatesApp,
      downloaderProgress,
    ];
  }

  static void createAll() {
    final androidPlugin = FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;
    for (final notification in all) {
      androidPlugin.createNotificationChannel(notification.android);
    }
  }
}
