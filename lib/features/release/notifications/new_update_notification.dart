import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:github/github.dart' hide Notification;
import 'package:nacht/core/core.dart';

import 'actions/actions.dart';

const _channel = NotificationChannel.appUpdateCheck;

class NewUpdateNotification extends Notification {
  const NewUpdateNotification(this.release);

  final Release release;

  @override
  String get title => 'New Update';

  @override
  String get body => 'Version ${release.tagName} is available for download';

  @override
  NotificationDetails? get notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        actions: [
          const AndroidNotificationAction(
            AppUpdateDownloadAction.id,
            'Download',
            cancelNotification: false,
          ),
          const AndroidNotificationAction('cancel', 'Cancel'),
        ],
      ),
    );
  }

  @override
  String? get payload => jsonEncode(release.toJson());
}
