import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';

class IncognitoNotification extends Notification {
  const IncognitoNotification();

  static const int id = 1;

  @override
  String get title => 'Incognito mode';

  @override
  String get body => 'Disable incognito mode';

  @override
  NotificationDetails? get notificationDetails {
    return NotificationChannels.incognitoMode.persistant();
  }
}
