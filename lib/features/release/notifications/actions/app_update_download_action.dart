import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';

class AppUpdateDownloadAction implements NotificationAction {
  static const String id = 'AppUpdateCheck.download';

  Future<void> execute(NotificationResponse response) async {
    print(id);
  }
}
