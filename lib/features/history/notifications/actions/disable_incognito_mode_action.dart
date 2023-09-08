import 'package:nacht/core/core.dart';
import 'package:nacht/features/history/history.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DisableIncognitoModeAction
    with LoggerMixin
    implements NotificationActionTask {
  @override
  Future<void> execute(RefRead read, NotificationResponse response) async {
    read(incognitoProvider.notifier).disableDiscrete();
  }
}
