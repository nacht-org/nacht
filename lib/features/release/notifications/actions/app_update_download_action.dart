import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';

import '../../background_tasks/background_tasks.dart';

class AppUpdateDownloadAction
    with LoggerMixin
    implements NotificationActionTask {
  static const String id = 'AppUpdate.Download';

  @override
  Future<void> execute(
    RefRead read,
    NotificationResponse response,
  ) async {
    final isConnectionAvailable =
        await read(getIsConnectionAvailableProvider).execute();
    if (!isConnectionAvailable) {
      log.info('update download cancelled: no internet connection');
      return;
    }

    AppUpdateDownloadTask.id.registerOnce(
      inputData: {'release': response.payload!},
    );
  }
}
